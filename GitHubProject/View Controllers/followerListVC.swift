//
//  followerListVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/15/20.
//

import UIKit

class followerListVC: UIViewController {
    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        //        navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //new way using Results<>
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result{
            
            case.failure(let error):
                self.presentGFalertOnMainThread(title: "Bad stuff Happend", message: error.rawValue, buttonTitle: "Shitt!!")
                
            case .success(let followers):
                print("Followers.count: \(followers.count)")
                print(followers)
                
                
                
            }
        }
        
        
        
        //        NetworkManager.shared.getFollowers(for: username, page: 1) { (followersSuccessful, errorMSG) in  //param can be whatever we want
        //            guard let followers = followersSuccessful else{
        //                self.presentGFalertOnMainThread(title: "Bad stuff Happend", message: errorMSG!.rawValue, buttonTitle: "Shitt!!")
        //                return
        //            }
        //
        //            print("Followers.count: \(followers.count)")
        //            print(followers)
        //        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true) // always call super when you are overriding
        //        navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
}
