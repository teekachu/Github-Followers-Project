//
//  GFRepoItemVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/20/20.
//

import UIKit

// inheritence from super class.
class GFRepoItemVC: GFItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems(){
        itemInfoViewOne.set(ItemInfoType: .repos, with: user.public_repos)
        itemInfoViewTwo.set(ItemInfoType: .gists, with: user.public_gists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
}
