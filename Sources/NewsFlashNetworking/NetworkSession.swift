//
//  NetworkSession.swift
//  NewsFlashNetworking
//
//  Created by Anurag Sharma on 01/08/25.
//
import Foundation

public protocol NetworkSession: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
extension URLSession: NetworkSession {}

