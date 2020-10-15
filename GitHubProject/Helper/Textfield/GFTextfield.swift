//
//  GFTextfield.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/14/20.
//

import UIKit

class GFTextfield: UITextField {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        becomeFirstResponder()
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 2
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label // black on lightMode and white on darkMode
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true // reduce font size to fit space
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no // because userNames could be weird and misspelled
        
        placeholder = "Enter a username" //placeholder text
        
        // customize keyboard type ( only for the return key)
        returnKeyType = .go
    }
    
    
    
}
