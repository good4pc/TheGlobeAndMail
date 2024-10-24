//
//  HomePageViewModelTests.swift
//  TheGlobeAndMailTests
//
//  Created by Prasanth pc on 2024-10-23.
//

import XCTest
@testable import TheGlobeAndMail

final class HomePageViewModelTests: XCTestCase {
    func test_loadHomePageContents_success() async {
        let data = Recommendations(recommendations: [Story(content_id: "324",
                                                           title: "23432",
                                                           protection_product: "red",
                                                           author: .author("pc"),
                                                           storyImage: PromotionImage(urls: PromotionImagesUrl(image_650: "")))])
        let mockClient = MockApiClient()
        mockClient.resultExpected = .success(GENERIC: data)
        let viewModel = HomePageViewModel(apiClient: mockClient)
        await viewModel.loadHomePageContents()
        await MainActor.run {
            XCTAssertEqual(viewModel.stories.count, 1)
            XCTAssertEqual(viewModel.stories[0].title, "23432")
            XCTAssertEqual(viewModel.stories[0].author.displayValue, "pc")
            XCTAssertTrue(viewModel.stories[0].showTrailingIcon)
        }
    }

    func test_loadHomePageContents_success_no_trailing_icon() async {
        let data = Recommendations(recommendations: [Story(content_id: "324",
                                                           title: "23432",
                                                           protection_product: "yellow",
                                                           author: .author("pc"),
                                                           storyImage: PromotionImage(urls: PromotionImagesUrl(image_650: "")))])
        let mockClient = MockApiClient()
        mockClient.resultExpected = .success(GENERIC: data)
        let viewModel = HomePageViewModel(apiClient: mockClient)
        await viewModel.loadHomePageContents()
        await MainActor.run {
            XCTAssertFalse(viewModel.stories[0].showTrailingIcon)
        }
    }

    func test_loadHomePageContents_failure() async {
        let mockClient = MockApiClient()
        mockClient.resultExpected = .failure(ApiClientError.decodingError)
        let viewModel = HomePageViewModel(apiClient: mockClient)
        await viewModel.loadHomePageContents()
        await MainActor.run {
            XCTAssertEqual(viewModel.errorString, "error")
        }
    }

    func test_authorDecodingTest() throws {
        let json = """
        {
        "recommendations": [
           {
            "content_id": "",
            "title": "",
            "protection_product": "",
            "byline": ["PC", "PC2"],
            "promo_image": {"urls": {"650": ""}}
           }
        ]
    }
"""
        let data = Data(json.utf8)
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(Recommendations.self, from: data)
        let story = try XCTUnwrap(decodedData.recommendations.first)
        XCTAssertEqual(story.author.displayValue, "PC and PC2")

        let json2 = """
        {
        "recommendations": [
           {
            "content_id": "",
            "title": "",
            "protection_product": "",
            "byline": ["PC"],
            "promo_image": {"urls": {"650": ""}}
           }
        ]
    }
"""
        let data2 = Data(json2.utf8)
        let decodedData2 = try decoder.decode(Recommendations.self, from: data2)
        let story2 = try XCTUnwrap(decodedData2.recommendations.first)
        XCTAssertEqual(story2.author.displayValue, "PC")
    }
}

enum ResultExpectation {
    case success(GENERIC: Decodable)
    case failure(Error)
}

final class MockApiClient: ApiClientProviding {
    public var resultExpected: ResultExpectation = .failure(ApiClientError.decodingError)
    func loadData<T>(urlRequest: URLRequest) async -> Result<T, Error> where T : Decodable {
        switch resultExpected {
        case .success(let model):
            if let model = model as? T {
                return .success(model)
            } else {
                return .failure(ApiClientError.decodingError)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
