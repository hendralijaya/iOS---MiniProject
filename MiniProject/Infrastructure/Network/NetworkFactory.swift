//
//  NetworkFactory.swift
//  StockPay
//
//  Created by NurFajar, Isa on 2024/07/06.
//

import Foundation

public enum NetworkFactory {
    //MARK: - AUTH
    case getMenus(searchText: String)
}

public extension NetworkFactory {
    // MARK: URL PATH API
    var path: String {
        switch self {
        case .getMenus:
            return "/api/json/v1/1/search.php"
        }
    }
    
    // MARK: URL QUERY PARAMS / URL PARAMS
    var queryItems: [URLQueryItem] {
        switch self {
        case .getMenus(let searchText):
            return [URLQueryItem(name: "s", value: searchText)]
        }
    }
    
    var bodyParam: [String: Any]? {
        switch self {
        case .getMenus:
            return [:]
        }
    }
    
    // MARK: BASE URL API
    var baseApi: String? {
        return "www.themealdb.com"
    }
    
    // MARK: URL LINK
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseApi
        components.path = path
        
        // Ensure proper handling of query items
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    // MARK: HTTP METHOD
    var method: RequestMethod {
        switch self {
        case .getMenus:
            return .get
        }
    }

    enum RequestMethod: String {
        case delete = "DELETE"
        case get = "GET"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
    }
    
    var boundary: String {
        let boundary: String = "Boundary-"
        return boundary
    }
    
    // MARK: MULTIPART DATA
    var data: [(paramName: String, fileData: Data, fileName: String)]? {
        return nil
    }
    
    // MARK: HEADER API
    var headers: [String: String]? {
        switch self {
        case .getMenus(searchText: _):
            return getHeaders(type: .authorized)
        }
    }

    enum HeaderType {
        case anonymous
        case authorized
        case appToken
        case multiPart
        case authorizedMultipart
    }
    
    fileprivate func getHeaders(type: HeaderType) -> [String: String] {
        
        let _ = UserDefaults.standard.string(forKey: "UserToken")
        
        var header: [String: String]
        
        switch type {
        case .anonymous:
            header = [:]
        case .authorized:
            header = [ "Accept": "application/json"]
            
        case .authorizedMultipart:
            header = ["Content-Type": "multipart/form-data; boundary=\(boundary)",
                      "Accept": "*/*",
                      "Authorization": "Basic \(setupBasicAuth())"]
        case .appToken:
            header = ["Content-Type": "application/json",
                      "Accept": "*/*"]
        case .multiPart:
            header = ["Content-Type": "multipart/form-data; boundary=\(boundary)",
                      "Accept": "*/*"]
        }
        return header
    }
    
    func createBodyWithParameters(parameters: [String: Any], imageDataKey: [(paramName: String, fileData: Data, fileName: String)]?, boundary: String) throws -> Data {
        return Data()
    }

    
    private func setupBasicAuth() -> String {
        let username = ""
        let password = ""
        let loginString = "\(username):\(password)"
        
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return ""
        }
        let _ = loginData.base64EncodedString()
        
        return "bmFuYS5udXJ3YW5kYUBnbWFpbC5jb206a2VyamErc2pzKzIwMjE="
    }
    
    var urlRequestMultiPart: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = method.rawValue
        let boundary = boundary
        if let header = headers {
            header.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let bodyParam = bodyParam, let datas = data {
            urlRequest.httpBody = try? createBodyWithParameters(parameters: bodyParam, imageDataKey: datas, boundary: boundary) as Data
        }
        
        return urlRequest
    }
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: self.url, timeoutInterval: 10.0)
        var bodyData: Data?
        urlRequest.httpMethod = method.rawValue
        if let header = headers {
            header.forEach { (key, value) in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let bodyParam = bodyParam, method != .get {
            do {
                bodyData = try JSONSerialization.data(withJSONObject: bodyParam, options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            } catch {
                // swiftlint:disable disable_print
                #if DEBUG
                print(error)
                #endif
                // swiftlint:enable disable_print
            }
        }
        return urlRequest
    }
}
