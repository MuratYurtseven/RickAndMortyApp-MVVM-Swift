//
//  RMOriginVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 23.12.2023.
//

import UIKit

class RMOriginVC: RMItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        imageView.image = SFSymbols.origin
        nameLabel.text = character.origin.name
        actionButton.setTitle("Origin", for: .normal)
        actionButton.backgroundColor = .systemBlue
    }
    
    override func actionButtonTapped() {
        delegate.didTapOrigin(for: character)
    }

}
