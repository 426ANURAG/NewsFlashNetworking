//
//  APIEndpoints.swift
//  NewsFlashNetworking
//
//  Created by Anurag Sharma on 31/07/25.
//

public enum APIEndpoint {
    case getNews(section: NewsSection, period: String)
    case dummy
    
    // URL path for each endpoint
    public var path: String {
        switch self {
        case .getNews(let section, let period):
            return "/svc/mostpopular/v2/mostviewed/\(section.rawValue)/\(period).json"
        case .dummy:
            return "/dummy"
        }
    }
    
    // Define HTTP Method for each endpoint (GET, POST, etc.)
    public var method: HttpMethod {
        switch self {
        case .getNews:
            return .GET
        case .dummy:
            return .GET
        }
    }
}
