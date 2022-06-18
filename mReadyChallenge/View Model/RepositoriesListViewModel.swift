//
//  RepositoriesListViewModel.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 18.06.2022.
//

import Foundation

struct RepositoryDisplayData: Identifiable {
    let id: Int
    let author: String
    let name: String
    let url: URL
    let stars: Int
    let forks: Int
    let watchers: Int
    let description: String?
}

final class RepositoriesListViewModel: ObservableObject {
    let loader: RepositoriesLoader
    
    @Published var repositories: [RepositoryDisplayData] = []
    
    init(loader: RepositoriesLoader) {
        self.loader = loader
        
        getRepos()
    }
    
    private func getRepos() {
        loader.getRepositories(completion: { [weak self] repositoriesResult in
            switch repositoriesResult {
            case .success(let repositories):
                for repository in repositories {
                    self?.getRepoDetails(for: repository)
                }
            case .failure:
                break
            }
        })
    }
    
    private func getRepoDetails(for repo: Repository) {
        loader.getRepositoryDetails(from: repo.url) { [weak self] repositoryResult in
            switch repositoryResult {
            case .success(let repositoryDetails):
                self?.repositories.append(RepositoryDisplayData(
                    id: repositoryDetails.id,
                    author: repositoryDetails.owner.login,
                    name: repositoryDetails.name,
                    url: URL(string: repositoryDetails.htmlUrl)!,
                    stars: repositoryDetails.stargazersCount,
                    forks: repositoryDetails.forks,
                    watchers: repositoryDetails.watchers,
                    description: repositoryDetails.description
                ))
            case .failure:
                break
            }
        }
    }
}
