//
//  URLRequestBuilder.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/13/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

class URLRequestBuilder {
    
    var request: URLRequest {
        return request(
            with: endpoint.baseURL.appendingPathComponent(endpoint.path),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 30
        )
    }
    
    private let endpoint: EndpointType
    private let jsonParameterEncoder: ParameterEncoder
    private let urlParameterEncoder: ParameterEncoder
    
    init(endpoint: EndpointType, jsonParameterEncoder: ParameterEncoder, urlParameterEncoder: ParameterEncoder) {
        self.endpoint = endpoint
        self.jsonParameterEncoder = jsonParameterEncoder
        self.urlParameterEncoder = urlParameterEncoder
    }
}

private extension URLRequestBuilder {
    
    func request(with url: URL, cachePolicy: URLRequest.CachePolicy, timeoutInterval: TimeInterval) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        switch endpoint.task {
        case let .request(bodyParameters, urlParameters, additionalHeaders):
            if let bodyParameters = bodyParameters {
                try? jsonParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }

            if let urlParameters = urlParameters {
                try? urlParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }

            if let additionalHeaders = additionalHeaders {
                additionalHeaders.forEach { key, value in
                    request.setValue(value, forHTTPHeaderField: key)
                }
            }
        }
        
        return request
    }
}

