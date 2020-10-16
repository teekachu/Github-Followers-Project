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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true) // always call super when you are overriding
        //        navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
}
