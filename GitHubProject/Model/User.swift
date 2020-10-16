//
//  User.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/15/20.
//

import Foundation

struct user: Codable {
    
    var login: String
    var avatar_url: String
    var name: String? // optional
    var location: String? // optional
    var bio: String? // optional
    
    var public_repos: Int
    var public_gists: Int
    var html_url: String
    
    var following: Int
    var followers: Int
    var created_at: String
    
}
