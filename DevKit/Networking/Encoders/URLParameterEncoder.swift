//
//  URLParameterEncoder.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/13/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else {
            throw NetworkError.missingURL
        }
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw NetworkError.invalidURL
        }
        
        let queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed))
        }
        
        urlComponents.queryItems = queryItems
        urlRequest.url = urlComponents.url
        urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
}
