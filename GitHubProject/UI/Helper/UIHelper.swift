//
//  UIHelper.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/17/20.
//

import UIKit

struct UIHelper{
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let width = view.bounds.width // total width of screen. regardless of what phone it is
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let totalAvailableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = totalAvailableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout

    }
}
