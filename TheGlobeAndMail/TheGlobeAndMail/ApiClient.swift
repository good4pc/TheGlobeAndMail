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

final class ApiClient: ApiClientProviding {
    enum ApiClientError: Error {
        case errorFetchingData
        case noResponseStatus
        case decodingError
    }

    private let urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func loadData<T: Decodable>(urlRequest: URLRequest) async -> Result<T, Error> {
        do {
            let (data,urlResponse) = try await urlSession.data(for: urlRequest)
            guard let _ = urlResponse as? HTTPURLResponse else {
                return .failure(ApiClientError.errorFetchingData)
            }
            //process anything based on status
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
}
