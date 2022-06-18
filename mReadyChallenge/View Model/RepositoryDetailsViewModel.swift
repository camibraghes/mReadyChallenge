//
//  RepositoryDetailsViewModel.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 18.06.2022.
//

import Foundation

class RepositoryDetailsViewModel {
    
    var repositoryData: RepositoryDisplayData
    var readMeContent: String?
    
    init(repositoryData: RepositoryDisplayData) {
        self.repositoryData = repositoryData
    }
}
