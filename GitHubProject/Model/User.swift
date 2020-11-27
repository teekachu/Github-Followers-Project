//
//  User.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/15/20.
//

import Foundation

struct user: Codable {
    
    let login: String
    let avatar_url: String
    var name: String? // optional
    var location: String? // optional
    var bio: String? // optional
    let public_repos: Int
    let public_gists: Int
    let html_url: String
    let following: Int
    let followers: Int
    var created_at: Date // used to be a String but using decoder.dateDecodingStrategy = .iso8601
}
