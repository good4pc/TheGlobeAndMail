//
//  MockUrlProtocol.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-27.
//

import Foundation

class MockUrlProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override func startLoading() {
        guard let handler = MockUrlProtocol.requestHandler else {
            //XCTFail("no request handler provided")
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            //XCTFail("Error Handling the request: \(error)")
        }
    }

    override func stopLoading() { }
}
