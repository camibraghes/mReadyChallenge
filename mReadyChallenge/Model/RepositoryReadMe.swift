//
//  RepositoryReadMe.swift
//  mReadyChallenge
//
//  Created by Camelia Braghes on 17.06.2022.
//

import Foundation

struct RepositoryReadMe: Decodable {
    let name: String
    let content: String
    
    var decodedContent: String? {
        // Remove all appearances of \n as the decoding will fail otherwise.
        let filteredContent = content.replacingOccurrences(of: "\n", with: "")
        guard let decodedData = Data(base64Encoded: filteredContent) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }
}
