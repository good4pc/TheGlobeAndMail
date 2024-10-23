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
