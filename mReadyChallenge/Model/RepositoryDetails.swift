//
//  RepositoryDetails.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 17.06.2022.
//

import Foundation

struct RepositoryDetails: Decodable {
    let id: Int
    let name: String
    let description: String?
    let forks: Int
    let watchers: Int
    let stargazersCount: Int
}
