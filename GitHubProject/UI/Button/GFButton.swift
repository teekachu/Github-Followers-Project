//
//  GFButton.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/14/20.
//

import UIKit

// building GFButton on top of UIButton
class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame) // making sure all the apple builts still exist
        // custom code
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init (backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure() // don't miss this one
    }
    
    //private means ONLY can be called in this call. NOT ALLOWED: GFButton.configure
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
//        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func set(backgroundColor: UIColor, title: String){
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
}
