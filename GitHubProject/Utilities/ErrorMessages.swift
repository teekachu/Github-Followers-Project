//
//  ErrorMessages.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/23/20.
//

import Foundation

// New way
enum GFError: String, Error {
    // raw values
    case invalidUsername = "Url created by this username is invalid. Please try again"
    case badInternetConnection = "Unable to complete your request. Please check your internet connection"
    case invalidResponseFromServer = "Invalid response from server, please try again"
    case invalidDataReceived = "Data received from server was invalid, please try again."
    case errorJSONParsing = "JSON Parcing was unsuccessful, please try again."
    case urlInvalid = "The url attached to this user is invalid"
    case unableToFavorite = "There was an error when favoriting this user, please try again."
    case alreadyInFavorites = "This user has already been favorited. You guys must be great friends!"
    case emptyUserName = "Please enter a username, we need to know who to look for 🤗"
}


/* OLD WAY
 enum ErrorMessage: String {
     // raw values
     case invalidUsername = "Url created by this username is invalid. Please try again"
     case badInternetConnection = "Unable to complete your request. Please check your internet connection"
     case invalidResponseFromServer = "Invalid response from server, please try again"
     case invalidDataReceived = "Data received from server was invalid, please try again."
     case errorJSONParsing = "JSON Parcing was unsuccessful, please try again."
 }
 */

