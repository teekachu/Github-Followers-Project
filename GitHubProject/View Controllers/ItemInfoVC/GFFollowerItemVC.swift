//
//  GFFollowerItemVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/20/20.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC{
    weak var delegate: GithubFollowersTappable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        configureButtonAction()
    }
    
    
    private func configureItems(){
        itemInfoViewOne.set(ItemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(ItemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: Colors.mediumBlueColor, title: "Get Followers")
    }
    
    
    private func configureButtonAction(){
        actionButton.addTarget(self, action: #selector(didTapGetFollowers), for: .touchUpInside)
    }
    
    
    @objc func didTapGetFollowers(){
        if let delegate = delegate{
            delegate.didTapGetFollowers(for: user)
        }
    }
    
}
