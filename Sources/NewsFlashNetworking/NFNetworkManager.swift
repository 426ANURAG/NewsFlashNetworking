//
//  NFNetworkManager.swift
//  NewsFlashNetworking
//
//  Created by Anurag Sharma on 31/07/25.
//

import Foundation

// Define your NetworkManager as an actor to ensure thread safety
public actor NetworkManager {
    
    // Singleton shared instance of NetworkManager using actor
    private static var _shared: NetworkManager?
    
    public static var shared: NetworkManager {
        get async {
            // This ensures the shared instance is lazily initialized in a thread-safe manner
            if _shared == nil {
                _shared = NetworkManager()
            }
            return _shared!
        }
    }
    
    private var environment: Environment
    private var session: NetworkSession
    
    // Make session configurable to support tests
    public init(environment: Environment = .development, session: NetworkSession = URLSession.shared) {
        self.environment = environment
        self.session = session
    }
    
    // Get the full URL based on endpoint and environment
    public func url(for endpoint: APIEndpoint) -> URL? {
        let url = environment.baseURL + endpoint.path + environment.keyPath
        return URL(string: url)
    }
    
    // Perform API request
    public func request<T: Decodable>(requestData: Networkrequest) async -> Result<T, NetworkError> {
        guard let url = url(for: requestData.endpoint) else { return .failure(.invalidURL)}
        var request = URLRequest(url: url)
        request.httpMethod = requestData.endpoint.method.rawValue
        // Attach headers to the request
        if let headers = requestData.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        // Attach body
        if let params = requestData.bodyParams {
            do {
                request.httpBody = try JSONEncoder().encode(params)
            } catch {
                return .failure(.encodingError(error))
            }
        }
        // Do request
        do {
            let (data, _) = try await session.data(for: request)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch let decodingError as DecodingError {
            return .failure(.decodingError(decodingError))
        } catch {
            return .failure(.networkFailure(error))
        }
    }
}

public enum HttpMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

public enum NetworkError: Error {
    case invalidURL
    case networkFailure(Error)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}
