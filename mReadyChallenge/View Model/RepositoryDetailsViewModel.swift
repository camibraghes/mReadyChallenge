//
//  RepositoryDetailsViewModel.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 18.06.2022.
//

import Foundation

final class RepositoryDetailsViewModel: ObservableObject  {
    
    @Published var readMeContent: String?
    var repositoryData: RepositoryDisplayData
    
    init(repositoryData: RepositoryDisplayData) {
        self.repositoryData = repositoryData
    }
}
