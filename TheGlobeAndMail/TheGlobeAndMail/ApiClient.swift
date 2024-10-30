//
//  ApiClient.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import Foundation

protocol ApiClientProviding: AnyObject {
    func loadData<T: Decodable>(urlRequest: URLRequest) async -> Result<T, Error>
}

enum ApiClientError: Error {
    case errorFetchingData
    case noResponseStatus
    case decodingError
}

final class ApiClient: ApiClientProviding {
    private var urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func loadData<T: Decodable>(urlRequest: URLRequest) async -> Result<T, Error> {
        do {
            let (data,urlResponse) = try await urlSession.data(for: urlRequest)
            guard let response = urlResponse as? HTTPURLResponse,
                  response.statusCode == 200 else {
                return .failure(ApiClientError.errorFetchingData)
            }

            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return .success(decodedData)
            } catch {
                return .failure(ApiClientError.decodingError)
            }
        } catch {
            return .failure(ApiClientError.errorFetchingData)
        }
    }

    private func configureUrlSession() {
        if ProcessInfo.processInfo.environment["UITESTING"] == "1" {
            let config = URLSessionConfiguration.ephemeral
            config.protocolClasses = [MockUrlProtocol.self]
            urlSession = URLSession(configuration: config)
        } else {
            urlSession = URLSession.shared
        }
    }
}
