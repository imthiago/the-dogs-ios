//
//  ApiClient.swift
//  TheDogs
//
//  Created by Thiago Oliveira on 07/12/21.
//

import Foundation

enum NetworkError: Error {
    case unexpected
}

enum HTTPMethod: String {
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
    case post = "POST"
}

protocol ApiClientProtocol {
    func request<T>(path: String,
                    method: HTTPMethod,
                    parameters: [String: Any]?,
                    headers: [String: String]?) async throws -> T? where T: Decodable
}

class ApiClient: ApiClientProtocol {

    // MARK: - Private properties

    private let urlSession: URLSession

    private lazy var decoder: JSONDecoder = {
        let decoder                     = JSONDecoder()
        decoder.keyDecodingStrategy     = .convertFromSnakeCase
        decoder.dateDecodingStrategy    = .iso8601
        return decoder
    }()

    // MARK: - Initialization
    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }

    func request<T>(path: String,
                    method: HTTPMethod,
                    parameters: [String: Any]?,
                    headers: [String: String]?) async throws -> T? where T: Decodable {

        guard var url = URL(string: "") else {
            throw NetworkError.unexpected
        }

        url.appendPathComponent(path)
        url.appendPathComponent(path)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        if let parameters = parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters as Any, options: [])
        }

        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let headers = headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }

        let (data, response) = try await urlSession.data(for: urlRequest)

        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
            throw NetworkError.unexpected
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.unexpected
        }
    }
}
