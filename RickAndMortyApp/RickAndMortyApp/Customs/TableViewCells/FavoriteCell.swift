//
//  FavoriteCell.swift
//  RickAndMortyApp
//
//  Created by Murat on 24.12.2023.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseId = "FavoriteCell"
    
    let avatarImageView = RMCharactersImageView(frame: .zero)
    let characterNameLabel = RMTitleLabel(textAligment: .left, fontSize: 30)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite:Character){
        characterNameLabel.text = favorite.name
        avatarImageView.downloandImage(from: favorite.image)
    }
    
    private func configure(){
        addSubview(avatarImageView)
        addSubview(characterNameLabel)
        
        accessoryType = .disclosureIndicator
        
        let padding:CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            characterNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 30),
            characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    

}
