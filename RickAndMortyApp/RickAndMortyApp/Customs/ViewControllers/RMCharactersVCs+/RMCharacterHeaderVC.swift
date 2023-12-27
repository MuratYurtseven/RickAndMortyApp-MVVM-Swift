//
//  RMCharacterHeaderVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 23.12.2023.
//

import UIKit

class RMCharacterHeaderVC: UIViewController {

    
    let characterImage = RMCharactersImageView(frame: .zero)
    let speciesLabel = RMSecondaryTitleLabel(fontSize: 25)
    let genderLabel = RMSecondaryTitleLabel(fontSize: 25)
    let statusLabel = RMSecondaryTitleLabel(fontSize: 25)
    let imageStatus = RMCharactersImageView(frame: .zero)
    var favoriteButton = RMFavoritedButton(image: SFSymbols.star)
    
    var views : [UIView] = []
    var isFavorited = false
    
    weak var delegate :RMCharacterDetailVCDelegate!
    
    var character : Character!
    
    init(character: Character) {
        super.init(nibName: nil, bundle: nil)
        self.character = character
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configure()
        controlFavoriteButton()
    }
    
    private func addSubviews(){
        views = [characterImage,speciesLabel,genderLabel,imageStatus,statusLabel,favoriteButton]
        
        for viewItem in views{
            view.addSubview(viewItem)
        }
    }
    
    private func layoutUI(){
        
        let padding : CGFloat = 20
        let textImagePadding : CGFloat = 15
        
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            characterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterImage.heightAnchor.constraint(equalToConstant: 220),
            characterImage.widthAnchor.constraint(equalToConstant: 220),
            
            speciesLabel.centerYAnchor.constraint(equalTo: characterImage.centerYAnchor,constant: -45),
            speciesLabel.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: textImagePadding),
            speciesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            speciesLabel.heightAnchor.constraint(equalToConstant: 27),
            
            genderLabel.centerYAnchor.constraint(equalTo: characterImage.centerYAnchor, constant: 0),
            genderLabel.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: textImagePadding),
            genderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            genderLabel.heightAnchor.constraint(equalToConstant: 27),
            
            imageStatus.topAnchor.constraint(equalTo: characterImage.centerYAnchor, constant: 45),
            imageStatus.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: textImagePadding),
            imageStatus.heightAnchor.constraint(equalToConstant: 15),
            imageStatus.widthAnchor.constraint(equalToConstant: 15),
            
            statusLabel.centerYAnchor.constraint(equalTo: imageStatus.centerYAnchor, constant: 0),
            statusLabel.leadingAnchor.constraint(equalTo: imageStatus.trailingAnchor, constant: textImagePadding),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            statusLabel.heightAnchor.constraint(equalToConstant: 27),
            
            favoriteButton.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: -55),
            favoriteButton.trailingAnchor.constraint(equalTo: characterImage.trailingAnchor,constant: -5),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    private func configure(){
        characterImage.downloandImage(from: character.image)
        speciesLabel.text = character.species
        genderLabel.text = character.gender
        statusLabel.text = character.status
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        
        switch character.status{
            
        case "Alive":
            imageStatus.image = SFSymbols.circleGreen
        case "Dead":
            imageStatus.image = SFSymbols.circleRed
        case "unknown":
            imageStatus.image = SFSymbols.circleGray
        default:
            return
        }
        
    }
    
    private func controlFavoriteButton(){
        PersistanceManager.retrieveFavorites {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let characters):
                if characters.contains(self.character) {
                    favoriteButton.setImage(SFSymbols.fillStar, for: .normal)
                    isFavorited = true
                } else {
                    favoriteButton.setImage(SFSymbols.star, for: .normal)
                    isFavorited = false
                }
            case .failure(let error):
                self.presentRMAlertMessageOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
    @objc func favoriteTapped(){
        if isFavorited {
            favoriteButton.setImage(SFSymbols.star, for: .normal)
            isFavorited = false
        } else {
            favoriteButton.setImage(SFSymbols.fillStar, for: .normal)
            isFavorited = true
        }
        delegate.didTapFavorited(for: character)
    }
    

        
}

