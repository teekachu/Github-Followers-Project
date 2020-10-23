//
//  PersistanceManager.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/22/20.
//

import Foundation


enum PersistanceManager {
    
    enum Keys{
        static let favorite = "favorites" }
    
    
    enum PersistanceActionType {
        case add, remove }
    
    
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completion: @escaping (GFError?) -> Void){ // esc closure send back an error
        // 1. retrieve favorite from user default - either success or failure.
        retreveFavorites { (result) in
            switch result{
            case .success(let favorites):
        
        // 2. put in a temp array
                var retrivedFavorites = favorites
                
        // 3. depends on what action to do
                switch actionType {
                case .add:
                    // does favorite exist? make sure it doesn't contain favorite, else error msg.
                    guard !retrivedFavorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return }
                    retrivedFavorites.append(favorite)
                    
                case .remove:
                    // go through the array and delete
                    retrivedFavorites.removeAll { $0.login == favorite.login }
                }
        
        // 4. save it in UserDefault again
                completion(save(favorites: retrivedFavorites))
                
            case .failure(let error):  // getting favorites failed. Pass the error
                completion(error)
            }
        }
        
    }
    
    // MARK: Retrive from UserDefaults.
    static private let defaults = UserDefaults.standard

    static func retreveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorite) as? Data else{
            completed(.success([])) // if return nil, means no favorites yet, so return empty array
            return
        }
        //if not nil, then not empty and send the array of favorites through completion closure
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch{
            completed(.failure(.unableToFavorite))
        }
    }
    
    // MARK: Save to UserDefaults.
    static func save(favorites: [Follower]) -> GFError?{  // if save successfully, return error might be nil.
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorite)
            return nil
        }catch {
            return .unableToFavorite
        }
    }
    
    
}
