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
    let url: URL
    let stars: Int
    let forks: Int
    let watchers: Int
    let description: String?
    let readMe: String?
}

struct RepositoryDetailsView: View {
    private enum Layout {
        static let headerNumbersTrailingPadding = 16.0
        static let headerBottomPadding = 16.0
        static let authorBottomPadding = 8.0
        static let horizontalPadding = 16.0
        static let scrollItemsSpacing = 32.0
    }
    
    var repositoryDetails: RepositoryDetailsDisplayData
    
    var body: some View {
        VStack {
            headerView
                .padding(.bottom, Layout.headerBottomPadding)
            
            ScrollView {
                VStack(alignment: .leading, spacing: Layout.scrollItemsSpacing) {
                    Text(repositoryDetails.description ?? "No description")
                        .font(.body.italic())
                        .foregroundColor(.gray)
                    Text(repositoryDetails.readMe ?? "No ReadMe file")
                }
            }
            .padding(.horizontal, Layout.horizontalPadding)
        }
    }
    
    private var headerView: some View {
        VStack {
            HStack{
                Text(repositoryDetails.name)
                    .font(.headline)
                Link(destination: repositoryDetails.url) {
                    Image(systemName: "link")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
            }
            
            Text(repositoryDetails.author)
                .font(.subheadline)
                .padding(.bottom, Layout.authorBottomPadding)
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("\(repositoryDetails.stars)")
                    .font(.caption)
                    .padding(.trailing, Layout.headerNumbersTrailingPadding)
        
                Image(systemName: "arrow.triangle.branch")
                    .font(.headline)
                Text("\(repositoryDetails.forks)")
                    .font(.caption)
                    .padding(.trailing, Layout.headerNumbersTrailingPadding)
                
                Image(systemName: "eye.fill")
                Text("\(repositoryDetails.watchers)")
                    .font(.caption)
                    .padding(.trailing, Layout.headerNumbersTrailingPadding)
            }
        }
    }
}

struct RepositoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailsView(repositoryDetails: RepositoryDetailsDisplayData(id: 1, author: "@Cami", name: "MyAwesomeRepo", url: URL(string: "https://github.com/camibraghes/SwiftUIProgress")!, stars: 230, forks: 3, watchers: 82, description: "This is the description of a hardcoded repo", readMe: "Welcome to my repo! Here you can find details about what is does, the content and purpose of it."))
    }
}
