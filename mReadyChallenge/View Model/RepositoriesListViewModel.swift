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
    private let loader: RepositoriesLoader
    
    @Published var repositories: [RepositoryDisplayData] = []
    
    init(loader: RepositoriesLoader) {
        self.loader = loader
        repositories = []
    }
}
