//
//  PostCodableStruct.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/03/26.
//

import Foundation

public class PostCodableStruct {
    
    
    // Show
    public struct Show: Codable {
        var title: String
        var user_id: Int
        var content: String
        var image: String?
        var createdAt: String
        var updatedAt: String
    }

    // Create
    public struct createJson: Codable {
        var content: String!
//        var image: String?
//        var audio: String?
        var user_id: Int!
    }
}
