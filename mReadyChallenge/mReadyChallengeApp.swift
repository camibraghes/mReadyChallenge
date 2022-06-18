//
//  mReadyChallengeApp.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 17.06.2022.
//

import SwiftUI

@main
struct mReadyChallengeApp: App {
    let repositoriesLoader = RepositoriesLoader()
    
    var body: some Scene {
        WindowGroup {
            RepositoriesList(viewModel: RepositoriesListViewModel(loader: repositoriesLoader))
        }
    }
}
