//
//  NetworkClient.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 17.06.2022.
//

import Combine
import Foundation

final class NetworkClient {
    private var cancellable = Set<AnyCancellable>()
    
    // Decoder used to decode JSONs with snake case properties
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    /// Performs a GET request and completes with a generic Result.
    /// - Parameters:
    ///   - response: The expected data type in the response.
    ///   - request: The URLRequest to be executed.
    ///   - completion: The result of the get request, verified and decoded.
    func get<Response: Decodable>(
        _ response: Response.Type,
        for request: URLRequest,
        completion: @escaping (Result<Response, GitHubError>
        ) -> Void) {
        // Start a task that makes the given request
        URLSession.shared.dataTaskPublisher(for: request)
            // Dispatches the result and future work to the main queue
            .receive(on: DispatchQueue.main)
            // Maps the result to `Data` if the response's status code is OK, or throws an error otherwise
            .tryMap { [weak self] (data, response) -> Data in
                guard self?.isStatusCodeOK(for: response) == true else {
                    throw GitHubError.badServerResponse
                }
                
                return data
            }
            // Decodes the received `Data` to the expected type using the decoder above
            .decode(type: response, decoder: self.decoder)
            // Calls the completion when the task has finished, using failure if the decoding above failed or success if everything went right
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure:
                    completion(Result.failure(GitHubError.decodingFailure))
                    break
                }
            }, receiveValue: { value in
                completion(Result.success(value))
            })
            // Stores the task to a cancellable set
            .store(in: &cancellable)
    }
    
    private func isStatusCodeOK(for response: URLResponse?) -> Bool {
        guard let response = response as? HTTPURLResponse else {
            return false
        }
        
        return response.statusCode >= 200 && response.statusCode < 300
    }
}
