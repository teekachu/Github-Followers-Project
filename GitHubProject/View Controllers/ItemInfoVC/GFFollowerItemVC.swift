//
//  GFFollowerItemVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/20/20.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems(){
        itemInfoViewOne.set(ItemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(ItemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
