//
//  Environment.swift
//  NewsFlashNetworking
//
//  Created by Anurag Sharma on 31/07/25.
//

import Foundation

public enum Environment {
    case development
    case production
    case mock
    
    public var baseURL: String {
        switch self {
        case .development:
            return "http://api.nytimes.com"
        case .production:
            return "http://api.nytimes.com"
        case .mock:
            return "http://mockapi.com"
        }
    }
    // Additional environment-related configurations can be added here
    private var apiKey: String {
        switch self {
        case .development:
            return "UvdMaeWkc8ZRGn0ConOYSPAPcc8JkMnp"
        case .production:
            return "UvdMaeWkc8ZRGn0ConOYSPAPcc8JkMnp"
        case .mock:
            return ""
        }
    }
    public var keyPath: String {
        return "?api-key=\(apiKey)"
    }
    
}

