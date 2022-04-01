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
        var status: String
        var posts: Posts
    }
    
    struct Posts: Codable {
        var current_page: Int
        var data: [PostsData]
        var first_page_url: String
        var from: Int
        var last_page: Int
        var last_page_url: String
        var links: [Links]
        var next_page_url: String?
        var path: String
        var per_page: String?
        var to: Int
        var total: Int
    }
    
    struct PostsData: Codable {
        var id: Int
        var user_id: Int
        var title: String
        var content: String
        var flag: Int
        var created_at: String
        var updated_at: String
        var audios: [Audios?]
        var comments: Comments
        var likes: Likes
        var created: String
        var user: User
        var images: [Images?]
        
    }
    
    struct Audios: Codable {
        var id: Int
        var user_id: Int
        var audio_id: Int
        var created_at: String
        var updated_at: String
        var composers: [Composers?]
        
    }
    
    struct Composers: Codable {
        var id: Int
        var user_id: Int
        var audio_id: Int
        var created_at: String
        var updated_at: String
        var user: User
    }
    
    struct Comments: Codable {
        var current_page: Int
        var data: [Comment]
        var first_page_url: String
        var from: String?
        var last_page: Int
        var last_page_url: String
        var links: [CommentsLinks]
        var next_page_url: String?
        var path: String
        var prev_page_url: String?
        var to: Int?
        var total: Int
    }
    
    struct CommentsLinks: Codable {
        var url: String?
        var label: String
        var active: Bool
    }
    
    struct Comment: Codable {
        
    }
    
    struct Links: Codable {
        var url: String?
        var label: String
        var active: Bool
    }
    
    struct Likes: Codable{
        var current_page: Int
        var data: [LinksData?]
        var first_page_url: String
        var from: String?
        var last_page: Int
        var last_page_url: String
        var links: [LikesLinks]
        var next_page_url: String
        var path: String
        var per_page: Int
        var prev_page_url: String?
        var to: Int?
        var total: Int
    }
    
    struct LinksData: Codable {
        
    }
    
    struct LikesLinks: Codable {
        var url: String?
        var label: String
        var active: Bool
    }
    
    struct User: Codable {
        var id: Int
        var name: String
        var email: String
        var image: String?
        var created_at: String
        var updated_at: String
    }
    
    struct Images: Codable {
        
    }
    
    
    
    
    

    // Create
    public struct createJson: Codable {
        var content: String!
//        var image: String?
//        var audio: String?
        var user_id: Int!
    }
    
    
}
