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
    let url: String
    let htmlUrl: URL
    let stars: Int
    let forks: Int
    let watchers: Int
    let description: String?
}

final class RepositoriesListViewModel: ObservableObject {
    let loader: RepositoriesLoader
    
    @Published var repositories: [RepositoryDisplayData] = []

    private var unsortedRepositories: [RepositoryDisplayData] = []
    private var totalRepos = 0
    private var downloadedRepos = 0
    
    init(loader: RepositoriesLoader) {
        self.loader = loader
        
        getRepos()
    }
    
    private func getRepos() {
        loader.getRepositories(completion: { [weak self] repositoriesResult in
            switch repositoriesResult {
            case .success(let repositories):
                self?.totalRepos = repositories.count
    
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
            self?.downloadedRepos += 1
            
            switch repositoryResult {
            case .success(let repositoryDetails):
                self?.unsortedRepositories.append(RepositoryDisplayData(
                    id: repositoryDetails.id,
                    author: repositoryDetails.owner.login,
                    name: repositoryDetails.name,
                    url: repo.url,
                    htmlUrl: URL(string: repositoryDetails.htmlUrl)!,
                    stars: repositoryDetails.stargazersCount,
                    forks: repositoryDetails.forks,
                    watchers: repositoryDetails.watchers,
                    description: repositoryDetails.description
                ))
            case .failure:
                break
            }
            
            if self?.downloadedRepos == self?.totalRepos {
                self?.updateViewWithSortedRepos()
            }
        }
    }
    
    private func updateViewWithSortedRepos() {
        repositories = unsortedRepositories.sorted(by: { repo1, repo2 in
            repo1.stars > repo2.stars
        })
    }
}
