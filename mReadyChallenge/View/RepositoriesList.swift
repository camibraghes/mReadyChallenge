//
//  RepositoriesList.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 17.06.2022.
//

import SwiftUI

struct RepositoryDisplayData: Identifiable {
    let id: Int
    let author: String
    let name: String
    let stars: Int
}

struct RepositoriesList: View {
    private enum Layout {
        static let verticalPadding = 16.0
    }
    
    var repositories = [RepositoryDisplayData]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(repositories) { repository in
                    NavigationLink {
                        Text("Details")
                    } label: {
                        RepositoryView(repository: repository)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .padding(.vertical, Layout.verticalPadding)
            .navigationTitle("Repositories")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct RepositoriesList_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesList(repositories: [
            RepositoryDisplayData(id: 1, author: "@Cami", name: "Repo1", stars: 23),
            RepositoryDisplayData(id: 2, author: "@Gigi", name: "Repo2", stars: 53),
            RepositoryDisplayData(id: 3, author: "@Adi", name: "Repo3", stars: 103)
        ])
    }
}
