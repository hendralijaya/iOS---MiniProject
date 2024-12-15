//
//  MockNetworker.swift
//  MiniProject
//
//  Created by hendra on 09/12/24.
//

import Foundation
import MiniProject

final class MockNetworker: NetworkerProtocol {
    var mockResponse: Any?
    var mockError: Error?

    func taskAsync<T: Decodable>(
        type: T.Type,
        endPoint: NetworkFactory,
        isMultipart: Bool
    ) async throws -> T {
        if let error = mockError {
            throw error
        }
        if let response = mockResponse as? T {
            return response
        }
        throw NSError(domain: "MockNetworker", code: -1, userInfo: [NSLocalizedDescriptionKey: "No mock data provided"])
    }
}
