//
//  RMContainerView.swift
//  RickAndMortyApp
//
//  Created by Murat on 21.12.2023.
//

import UIKit

class RMContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor,cornerRadius: CGFloat,borderWidth : CGFloat,borderColor: UIColor){
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    private func  configure(){
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
