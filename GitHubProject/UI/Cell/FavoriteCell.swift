//
//  FavoriteCell.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/23/20.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID = "FavoriteCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 25)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview()
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubview(){
        
        addSubview(avatarImageView)
        addSubview(usernameLabel)
    }
    
    
    func set(favorites: Follower){
        
        usernameLabel.text = favorites.login
        avatarImageView.downloadImage(from: favorites.avatar_url)
    }
    
    
    private func configure(){
        
        accessoryType = .disclosureIndicator  // > thing on the right of table view
        let padding: CGFloat = 12
        let imageSize:CGFloat = 60
//        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
//        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: imageSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: imageSize),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding * 2),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
