//
//  CharactersCell.swift
//  RickAndMortyApp
//
//  Created by Murat on 22.12.2023.
//

import UIKit

class CharactersCell: UICollectionViewCell {
    
    static let resuseId = "CharactersCell"
    
    let characterImage = RMCharactersImageView(frame: .zero)
    let characterNameLabel = RMTitleLabel(textAligment: .center, fontSize: 16)
    
    var views : [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(character:Character){
        characterNameLabel.text = character.name
        characterImage.downloandImage(from: character.image)
    }
    
    private func configure(){
        addSubview(characterImage)
        addSubview(characterNameLabel)
    
        let padding : CGFloat = 8
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            characterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            characterImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            characterImage.heightAnchor.constraint(equalTo: characterImage.widthAnchor),
            
            characterNameLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 12),
            characterNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }

}
