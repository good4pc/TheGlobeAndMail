//
//  UrlConfigurations.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import Foundation

class UrlConfigurations {
    enum UrlConfigurationsError: Error {
        case urlIncorrect
    }

    enum EndPoint {
        case homePageListing

        var path: String {
            switch self {
            case .homePageListing:
                "trending_and_sophi/recommendations.json"
            }
        }
    }

    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func getUrlRequest(endPoint: EndPoint) throws -> URLRequest {
        let urlString = baseUrl + endPoint.path
        guard let url = URL(string: urlString) else {
            throw UrlConfigurationsError.urlIncorrect
        }
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}
