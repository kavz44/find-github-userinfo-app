//
//  GithubUser.swift
//  FirstAPICallApp
//
//  Created by Kavin Gregary Anand on 28/09/2025.
//

struct GithubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String?
    let location: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case bio
        case location
        case createdAt = "created_at"
    }
}
