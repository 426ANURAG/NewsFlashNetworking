//
//  File.swift
//  NewsFlashNetworking
//
//  Created by Anurag Sharma on 01/08/25.
//

import Foundation
@testable import NewsFlashNetworking

actor MockSessionState {
    var responseData: Data?
    var response: URLResponse?
    var error: Error?
}

final class MockSession: NetworkSession {
    let state = MockSessionState()
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = await state.error {
            throw error
        }
        
        guard let data = await state.responseData, let response = await state.response else {
            throw URLError(.badServerResponse)
        }
        
        return (data, response)
    }
    
    func configure(responseData: Data?, response: URLResponse?, error: Error?) async {
        await state.setValues(data: responseData, response: response, error: error)
    }
}
extension MockSessionState {
    func setValues(data: Data?, response: URLResponse?, error: Error?) {
        self.responseData = data
        self.response = response
        self.error = error
    }
}
