//
//  Repository.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 17.06.2022.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let fork: Bool
    let url: String
    let owner: GitHubUser
}
