//
//  GFSecondaryTitleLabel.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/20/20.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    // required for storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // create custome init
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero) // what does this do/
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    // configure func
    private func configure(){
        
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .secondaryLabel // black on light and white on dark
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail  //(... for the hidden words)
    }

}
