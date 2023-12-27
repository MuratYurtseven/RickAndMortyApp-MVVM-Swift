//
//  RMBodyLabel.swift
//  RickAndMortyApp
//
//  Created by Murat on 21.12.2023.
//

import UIKit

class RMBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAligment : NSTextAlignment){
        self.init(frame: .zero)
        self.textAlignment = textAligment
    }
    
    private func configure(){
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.5
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
