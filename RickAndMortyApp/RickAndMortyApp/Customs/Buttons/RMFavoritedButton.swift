//
//  RMFavoritedButton.swift
//  RickAndMortyApp
//
//  Created by Murat on 23.12.2023.
//

import UIKit

class RMFavoritedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    convenience init(image:UIImage){
        self.init(frame: .zero)
        self.setImage(image, for: .normal)
    }
    
    
    private func configure(){
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
        tintColor = .yellow
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
