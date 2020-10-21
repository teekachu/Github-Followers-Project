//
//  GFUserInfoHeaderVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/20/20.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageview = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)
    
    var user: user!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        layoutUI()
        configureUIElements()
    }
    
    
    init(user: user){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addSubviews(){
        view.addSubview(avatarImageview)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    
    func layoutUI(){
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false // the other ones are false already
        
        NSLayoutConstraint.activate([
            avatarImageview.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageview.widthAnchor.constraint(equalToConstant: 90),
            avatarImageview.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageview.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageview.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageview.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageview.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageview.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageview.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageview.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageview.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
    
    func configureUIElements(){
        avatarImageview.downloadImage(from: user.avatar_url)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "no location"
        bioLabel.text = user.bio ?? "no bio available"
        bioLabel.numberOfLines = 3
        
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
        
    }
    
    
}
