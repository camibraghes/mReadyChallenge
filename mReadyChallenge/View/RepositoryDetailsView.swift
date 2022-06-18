//
//  RepositoryDetailsView.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 18.06.2022.
//

import SwiftUI

struct RepositoryDetailsDisplayData: Identifiable {
    let id: Int
    let author: String
    let name: String
    let stars: Int
    let forks: Int
    let watchers: Int
    let description: String?
    let readMe: String?
}

struct RepositoryDetailsView: View {
    
    var readMeDetail: RepositoryDetailsDisplayData
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RepositoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailsView(readMeDetail: RepositoryDetailsDisplayData(id: 1, author: "@Cami", name: "MyAwesomeRepo", stars: 230, forks: 3, watchers: 82, description: "This is the description of a hardcoded repo", readMe: "Welcome to my repo! Here you can find details about what is does, the content and purpose of it."))
    }
}
