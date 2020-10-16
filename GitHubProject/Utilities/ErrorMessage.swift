//
//  errorMessage.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/16/20.
//

import Foundation

enum ErrorMessage: String {
    // raw values 
    case invalidUsername = "Url created by this username is invalid. Please try again"
    
    case badInternetConnection = "Unable to complete your request. Please check your internet connection"
    
    case invalidResponseFromServer = "Invalid response from server, please try again"
    
    case invalidDataReceived = "Data received from server was invalid, please try again."
    
    case errorJSONParsing = "JSON Parcing was unsuccessful, please try again."
}
