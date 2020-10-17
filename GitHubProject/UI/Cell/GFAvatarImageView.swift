//
//  GFAvatarImageView.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/16/20.
//

import UIKit

class GFAvatarImageView: UIImageView {

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
}
