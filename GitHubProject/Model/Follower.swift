//
//  Follower.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/15/20.

import Foundation

// RULE OF THUMB: if we dont need inheritance for something, use a struct.
// More performant and lighter

struct Follower: Codable {
    
    var login: String // not an optional because both fields are mandatory ( default provided by github if doesn't have their own avatar)
    var avatar_url: String
    
}
