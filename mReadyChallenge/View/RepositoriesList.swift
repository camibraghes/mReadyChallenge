//
//  RepositoriesList.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 17.06.2022.
//

import SwiftUI

struct RepositoriesList: View {
    private enum Layout {
        static let verticalPadding = 16.0
    }
    
    @ObservedObject var viewModel: RepositoriesListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repositories) { repository in
                    NavigationLink {
                        RepositoryDetailsView(viewModel: RepositoryDetailsViewModel(repositoryData: repository))
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
        RepositoriesList(viewModel: RepositoriesListViewModel(loader: RepositoriesLoader()))
    }
}
