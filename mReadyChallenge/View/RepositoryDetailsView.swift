//
//  RepositoryDetailsView.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 18.06.2022.
//

import SwiftUI

struct RepositoryDetailsView: View {
    private enum Layout {
        static let headerNumbersTrailingPadding = 16.0
        static let headerBottomPadding = 16.0
        static let authorBottomPadding = 8.0
        static let horizontalPadding = 16.0
        static let scrollItemsSpacing = 32.0
    }
    
    @ObservedObject var viewModel: RepositoryDetailsViewModel
    
    var body: some View {
        VStack {
            headerView
                .padding(.bottom, Layout.headerBottomPadding)
            
            ScrollView {
                VStack(alignment: .leading, spacing: Layout.scrollItemsSpacing) {
                    Text(viewModel.repositoryData.description ?? "No description")
                        .font(.body.italic())
                        .foregroundColor(.gray)
                    Text(viewModel.readMeContent ?? "No ReadMe file")
                }
            }
            .padding(.horizontal, Layout.horizontalPadding)
        }
    }
    
    private var headerView: some View {
        VStack {
            HStack{
                Text(viewModel.repositoryData.name)
                    .font(.headline)
                Link(destination: viewModel.repositoryData.url) {
                    Image(systemName: "link")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
            }
            
            Text(viewModel.repositoryData.author)
                .font(.subheadline)
                .padding(.bottom, Layout.authorBottomPadding)
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("\(viewModel.repositoryData.stars)")
                    .font(.caption)
                    .padding(.trailing, Layout.headerNumbersTrailingPadding)
        
                Image(systemName: "arrow.triangle.branch")
                    .font(.headline)
                Text("\(viewModel.repositoryData.forks)")
                    .font(.caption)
                    .padding(.trailing, Layout.headerNumbersTrailingPadding)
                
                Image(systemName: "eye.fill")
                Text("\(viewModel.repositoryData.watchers)")
                    .font(.caption)
                    .padding(.trailing, Layout.headerNumbersTrailingPadding)
            }
        }
    }
}

struct RepositoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailsView(viewModel: RepositoryDetailsViewModel(loader: RepositoriesLoader(), repositoryData: RepositoryDisplayData(id: 1, author: "@Cami", name: "MyAwesomeRepo", url: URL(string: "https://github.com/camibraghes/SwiftUIProgress")!, stars: 230, forks: 3, watchers: 82, description: "This is the description of a hardcoded repo")))
    }
}
