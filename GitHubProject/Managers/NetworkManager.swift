//
//  NetworkManager.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/16/20.
//

import UIKit

// singleton
class NetworkManager{
    
    // static means shared with other instances/values/ ie. every other network manager
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com"
    let cache = NSCache<NSString, UIImage>() // put it here because since NM is a singleton, there will only be one cache.
    
    private init(){
        
    }
    
    // the completion handler is either getting an array of Followers back, or we will get ErrorMessage back ( what we created )
    
    /* old way
     func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]? , ErrorMessage?) -> Void){
     */
    
    //new way to use Result<>
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void){
        
        // need followers URL
        let endpoint = baseURL + "/users/\(username)/followers?per_page=100&page=\(page)"
        
        // make sure url string can be translated into valid URL
        guard let url = URL(string: endpoint) else{
            // error handling for the url
            //            completion(nil, .invalidUsername)
            completion(.failure(.invalidUsername))
            return
        }
        
        // if url was successful , continue
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // network call
            if let _ = error{
                //                completion(nil, .badInternetConnection)
                completion(.failure(.badInternetConnection))
                return
            }
            
            // if response is not nil, put it in response as HTTPresponse, ALSO, check status code to see if its 200(OK).
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                //                completion(nil, .invalidResponseFromServer)
                completion(.failure(.invalidResponseFromServer))
                return
            }
            
            guard let data = data else{
                //                completion(nil, .invalidDataReceived )
                completion(.failure(.invalidDataReceived))
                return
            }
            
            // parse JSON
            
            do{
                let decoder = JSONDecoder()
                //                decoder.keyDecodingStrategy = .convertFromSnakeCase // do i need this???
                let followers = try decoder.decode([Follower].self, from: data)
                //                completion(followers, nil)
                completion(.success(followers))
                
            } catch{
                //                completion(nil, .errorJSONParsing)
                completion(.failure(.errorJSONParsing))
                
            }
            
        }
        //MARK: IMPORTANT - This actually starts the network call
        task.resume()
    }
    
    
    
    
    
}
