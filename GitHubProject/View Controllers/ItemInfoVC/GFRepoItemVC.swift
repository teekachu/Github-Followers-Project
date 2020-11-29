//
//  GFRepoItemVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/20/20.
//

import UIKit

// inheritence from super class.
class GFRepoItemVC: GFItemInfoVC{
    weak var delegate: GithubProfileTappable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        configureButtonAction()
    }
    
    
    private func configureItems(){
        itemInfoViewOne.set(ItemInfoType: .repos, with: user.public_repos)
        itemInfoViewTwo.set(ItemInfoType: .gists, with: user.public_gists)
        actionButton.set(backgroundColor: Colors.darkGrey304057, title: "Github Profile")
    }
    
    
    private func configureButtonAction(){
        actionButton.addTarget(self, action: #selector(didTapGithubProfile), for: .touchUpInside)
    }
    
    @objc func didTapGithubProfile(){
        if let delegate = delegate{
            delegate.didTapGithubProfile(for: user)
        }
    }
    
}
