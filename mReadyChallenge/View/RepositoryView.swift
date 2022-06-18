//
//  RepositoryView.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 18.06.2022.
//

import SwiftUI

struct RepositoryView: View {
    private enum Layout {
        static let verticalSpacing = 8.0
        static let verticalPadding = 4.0
        static let starsPadding = 2.0
    }
    
    let repository: RepositoryDisplayData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Layout.verticalSpacing) {
                Text(repository.name)
                    .font(.headline)
                Text(repository.author)
                    .font(.subheadline)
            }
                
            Spacer()
            
            VStack(alignment: .trailing) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("\(repository.stars)")
                    .font(.caption)
                    .padding(Layout.starsPadding)
            }
        }
        .padding(.vertical, Layout.verticalPadding)
    }
}

struct RepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView(repository: RepositoryDisplayData(id: 1, author: "Cami", name: "MyAwesomeRepo", stars: 123))
    }
}
