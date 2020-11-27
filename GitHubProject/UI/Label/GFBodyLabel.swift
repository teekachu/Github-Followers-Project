//
//  GFBodyLabel.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/15/20.
//

import UIKit

class GFBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    
    private func configure(){
        
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.preferredFont(forTextStyle: .body) //DYNAMIC TYPE
        textColor = .secondaryLabel // lightGray
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping  //(... for the hidden words)
    }
    
    
}
