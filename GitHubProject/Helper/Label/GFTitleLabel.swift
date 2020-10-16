//
//  GFTitleLabel.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/15/20.
//

import UIKit

class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    // required for storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // create custome init
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero) // what does this do/
        
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    
    // configure func
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label // black on light and white on dark
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail  //(... for the hidden words)
    }
    
}
