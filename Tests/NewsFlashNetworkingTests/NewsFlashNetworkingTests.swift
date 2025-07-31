import XCTest
@testable import NewsFlashNetworking

final class NewsFlashNetworkingTests: XCTestCase {
    var mockSession: MockSession!
    var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        mockSession = MockSession()
        networkManager = NetworkManager(
            environment: .mock,
            session: mockSession
        )
    }

    func testSuccessfulResponse() async throws {
        // Given
        let expected = DummyResponse(message: "Hello")
        let jsonData = try JSONEncoder().encode(expected)
        let response = HTTPURLResponse(
            url: URL(string: "https://mockapi.com/dummy")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        await mockSession.configure(responseData: jsonData, response: response, error: nil)
        
        let request = Networkrequest(endpoint: .dummy)
        
        // When
        let result: Result<DummyResponse, NetworkError> = await networkManager.request(requestData: request)
        
        // Then
        switch result {
        case .success(let data):
            XCTAssertEqual(data, expected)
        case .failure(let error):
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testDecodingFailure() async throws {
        // Given
        let invalidJSON = Data("not valid json".utf8)
        let response = HTTPURLResponse(
            url: URL(string: "https://mockapi.com/dummy")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        await mockSession.configure(responseData: invalidJSON, response: response, error: nil)
        
        let request = Networkrequest(endpoint: .dummy)
        let result: Result<DummyResponse, NetworkError> = await networkManager.request(requestData: request)
        
        // Then
        if case .failure(.decodingError) = result {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected decoding error")
        }
    }
    
    func testNetworkFailure() async throws {
        // Given
        let error = URLError(.notConnectedToInternet)
        await mockSession.configure(responseData: nil, response: nil, error: error)
        
        let request = Networkrequest(endpoint: .dummy)
        let result: Result<DummyResponse, NetworkError> = await networkManager.request(requestData: request)
        
        // Then
        if case .failure(.networkFailure(let err as URLError)) = result {
            XCTAssertEqual(err.code, .notConnectedToInternet)
        } else {
            XCTFail("Expected network failure")
        }
    }
}
