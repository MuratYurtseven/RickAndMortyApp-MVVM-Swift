//
//  UIHelper.swift
//  RickAndMortyApp
//
//  Created by Murat on 23.12.2023.
//

import Foundation
import UIKit

struct UIHelper{
    
    
    static func createTwoColumnFlowLayout(in view :UIView) -> UICollectionViewFlowLayout {
        
        let width = view.bounds.width
        let padding: CGFloat = 8
        let minimumLineSpacing : CGFloat = 10
        let availableWidth = width - (padding*2) - minimumLineSpacing
        let itemWidth = availableWidth/2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth+50)
        return flowLayout
    }

    static func createOneColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout{
        
        let width = view.bounds.width
        let padding : CGFloat = 12
        let availableWidth = width - (padding*2)
        let itemWidth = availableWidth
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth+50)
        return flowLayout
    }
    
}
