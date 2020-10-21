//
//  GFItemInfoView.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/20/20.
//

import UIKit

enum itemInfoType{
    case repos, gists, following, followers
}

class GFItemInfoView: UIView {
    let symbolImageview = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        addSubview(symbolImageview)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageview.translatesAutoresizingMaskIntoConstraints = false
        symbolImageview.contentMode = .scaleAspectFit
        symbolImageview.tintColor = .label
    }
    
    
    private func layoutUI(){
        NSLayoutConstraint.activate([
            symbolImageview.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageview.widthAnchor.constraint(equalToConstant: 20),
            symbolImageview.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageview.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageview.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageview.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func set(ItemInfoType: itemInfoType, with count: Int){
        
        switch ItemInfoType{
        case .repos:
            symbolImageview.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageview.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .following:
            symbolImageview.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        case .followers:
            symbolImageview.image = UIImage(systemName: SFSymbols.follwers)
            titleLabel.text = "Followers"
        }
        
        countLabel.text = String(count)
    }
}
