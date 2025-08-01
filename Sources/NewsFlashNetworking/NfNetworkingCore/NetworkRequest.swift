//
//  NetworkRequest.swift
//  NewsFlashNetworking
//
//  Created by Anurag Sharma on 31/07/25.
//
public struct Networkrequest {
    public var endpoint: APIEndpoint
    public var bodyParams: Encodable?
    public var headers: [String: String]?
    
    public init(
            endpoint: APIEndpoint,
            bodyParams: Encodable? = nil,
            headers: [String: String]? = nil
        ) {
            self.endpoint = endpoint
            self.bodyParams = bodyParams
            self.headers = headers
        }
}
