//
//  MovieServices.swift
//  ApiMvvm
//
//  Created by hendra on 22/10/24.
//

import Foundation

protocol MenuServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getMenu(endPoint: NetworkFactory) async throws -> MenuResponse
}

final class MenuServicesImpl: MenuServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func getMenu(endPoint: NetworkFactory) async throws -> MenuResponse {
        return try await networker.taskAsync(type: MenuResponse.self, endPoint: endPoint, isMultipart: false)
    }
}
