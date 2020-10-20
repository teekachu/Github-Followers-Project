//
//  GFemptyStateView.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/19/20.
//

import UIKit

class GFemptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    let imageName = "empty-state-logo"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(message: String){
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    
    private func configure(){
        addSubview(messageLabel)
        addSubview(logoImageView)
        configureMessageLabel()
        configureLogoImageView()
    }
    
    
    private func configureMessageLabel(){
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150), // moving it up from center
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureLogoImageView(){
        logoImageView.image = UIImage(named: imageName)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3), // take image and make width 1.3 times than the actual width of screen
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200), // pushing it to the right
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 55)
        ])
    }
}
