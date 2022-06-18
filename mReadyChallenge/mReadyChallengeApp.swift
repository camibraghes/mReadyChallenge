//
//  mReadyChallengeApp.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 17.06.2022.
//

import SwiftUI

@main
struct mReadyChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            RepositoriesList(
                repositories: [
                    RepositoryDisplayData(id: 1, author: "@Cami", name: "Repo1", stars: 23),
                    RepositoryDisplayData(id: 2, author: "@Gigi", name: "Repo2", stars: 53),
                    RepositoryDisplayData(id: 3, author: "@Adi", name: "Repo3", stars: 103)
                ], repositoryDetails: RepositoryDetailsDisplayData(
                    id: 1,
                    author: "@Cami",
                    name: "MyAwesomeRepo",
                    stars: 230,
                    forks: 3,
                    watchers: 82,
                    description: "This is the description of a hardcoded repo",
                    readMe: "Welcome to my repo! Here you can find details about what is does, the content and purpose of it."
                )
            )
        }
    }
}
