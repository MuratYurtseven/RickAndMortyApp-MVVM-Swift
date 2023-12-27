//
//  RMItemInfoVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 23.12.2023.
//

import UIKit

class RMItemInfoVC: UIViewController {
    
    let imageView = RMCharactersImageView(frame: .zero)
    let nameLabel = RMSecondaryTitleLabel(fontSize: 18)
    let actionButton = RMButton()
    
    weak var delegate : RMCharacterDetailVCDelegate!
    
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
        configureBackgroundColor()
        layoutUI()
        configureActionButton()
    }
    private func configureBackgroundColor(){
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func layoutUI(){
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(actionButton)
        
        let padding : CGFloat = 20
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            imageView.heightAnchor.constraint(equalToConstant: 25),
            imageView.widthAnchor.constraint(equalToConstant: 25),
            
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            actionButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureActionButton(){
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped(){
        
    }

}
