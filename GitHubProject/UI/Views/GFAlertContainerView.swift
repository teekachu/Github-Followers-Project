//
//  GFAlertContainerView.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/24/20.
//

import UIKit

class GFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground }
}
