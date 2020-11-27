//
//  GFAvatarImageView.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/16/20.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    //MARK: Cache
    let cache = NetworkManager.shared.cache // pulling from NwManager. 
    let imagePlaceHolder = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        
        layer.cornerRadius = 10
        clipsToBounds = true // also put corner on the image instead of just the imageview container
        translatesAutoresizingMaskIntoConstraints = false
        image = imagePlaceHolder
    }
    
    
    // placeholder image available so not using an alert / thus excluding from NetworkManager file
    func downloadImage(from urlString: String) {
        
        //MARK: Cache continue
        // check for the image in cashe , if exist, pull ; else download
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            self.image = image
            return // pull the image and return
        }
        
        guard let url = URL(string: urlString) else{return}
        
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            
            if error != nil{ return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else{ return }
            
            guard let image = UIImage(data: data) else{ return }  // set image to be image
            self?.cache.setObject(image, forKey: cacheKey) // set the image to cache
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                
                self.image = image
            }
            
        }
        
        task.resume()
        
    }
}
