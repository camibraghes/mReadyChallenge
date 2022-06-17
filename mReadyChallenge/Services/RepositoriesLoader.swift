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

// A class responsible for loading data about GitHub repositories using the GitHub API.
final class RepositoriesLoader {
    private let networkClient = NetworkClient()
    private let repositoriesURLString = "https://api.github.com/repositories"
    
    // For a simpler code reading
    typealias RepositoriesResult = Result<[Repository], GitHubError>
    typealias RepositoryResult = Result<RepositoryDetails, GitHubError>
    typealias RepositoryReadMeResult = Result<RepositoryReadMe, GitHubError>

    /// Gets the public GitHub repositories.
    /// - Parameter completion: The result of the get request, verified and decoded.
    func getRepositories(completion: @escaping (RepositoriesResult) -> Void) {
        guard let url = URL(string: repositoriesURLString) else {
            completion(Result.failure(GitHubError.badUrl))
            return
        }
        
        let request = createURLRequest(for: url)
        networkClient.get([Repository].self, for: request, completion: completion)
    }
    
    /// Gets the details for a given GitHub repository.
    /// - Parameter url: The URL String of the GitHub repo to be fetched.
    /// - Parameter completion: The result of the get request, verified and decoded.
    func getRepositoryDetails(from url: String, completion: @escaping (RepositoryResult) -> Void) {
        guard let url = URL(string: url) else {
            completion(Result.failure(GitHubError.badUrl))
            return
        }
        
        let request = createURLRequest(for: url)
        networkClient.get(RepositoryDetails.self, for: request, completion: completion)
    }
    
    /// Gets the ReadMe for a given GitHub repository.
    /// - Parameters:
    ///   - url: The URL String of the GitHub repo to be fetched.
    ///   - completion: The result of the get request, verified and decoded.
    func getRepositoryReadMe(from url: String, completion: @escaping (RepositoryReadMeResult) -> Void ) {
        guard let url = URL(string: String (url + "/readme")) else {
            completion(Result.failure(GitHubError.badUrl))
            return
        }
        
        let request = createURLRequest(for: url)
        networkClient.get(RepositoryReadMe.self, for: request, completion: completion)
    }
    
    private func createURLRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        // Header is required per GitHub documentation
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        return request
    }
}
