//
//  RepositoriesLoader.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 17.06.2022.
//

import Foundation
import Combine

// Defining our own `Error`s to be handled later as we wish
enum GitHubError: Error {
    case badUrl
    case badServerResponse
    case decodingFailure
}

// A loader responsible for loading the public GitHub repositories using the GitHub API
final class RepositoriesLoader {
    
    // For a simpler code reading
    typealias RepositoriesResult = Result<[Repository], Error>
    
    private let repositoriesURLString = "https://api.github.com/repositories"
    private var cancellable = Set<AnyCancellable>()
    
    // Decoder used to decode JSONs with snake case properties
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    /// Gets the public GitHub repositories.
    /// - Parameter completion: The result of the get request, verified and decoded.
    func getRepositories(completion: @escaping (RepositoriesResult) -> Void) {
        guard let url = URL(string: repositoriesURLString) else {
            completion(Result.failure(GitHubError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        // Header is required per GitHub documentation
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
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
            // Decodes the received `Data` to the expected type ([Repository]) using the decoder above
            .decode(type: [Repository].self, decoder: self.decoder)
            // Calls the completion when the task has finished, using failure if the decoding above failed
            // or success with the resulted repositories if everything went right
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure:
                    completion(Result.failure(GitHubError.decodingFailure))
                }
            }, receiveValue: { repositories in
                completion(Result.success(repositories))
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
