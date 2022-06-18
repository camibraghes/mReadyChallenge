//
//  RepositoryDetailsViewModel.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 18.06.2022.
//

import Foundation

final class RepositoryDetailsViewModel: ObservableObject  {
    private let loader: RepositoriesLoader

    @Published var readMeContent: String?
    var repositoryData: RepositoryDisplayData
    
    init(loader: RepositoriesLoader, repositoryData: RepositoryDisplayData) {
        self.loader = loader
        self.repositoryData = repositoryData
        
        getReadMe()
    }
    
    private func getReadMe() {
        loader.getRepositoryReadMe(from: repositoryData.url) { [weak self] result in
            switch result {
            case .success(let readMe):
                self?.readMeContent = readMe.decodedContent
            case .failure:
                break
            }
        }
    }
}
