//
//  RMLocationVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 23.12.2023.
//

import UIKit

class RMLocationVC: RMItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    private func configureItems(){
        
        imageView.image = SFSymbols.loacation
        nameLabel.text = character.location.name
        actionButton.setTitle("Location", for: .normal)
        actionButton.backgroundColor = .systemGreen
    }
    
    override func actionButtonTapped() {
        delegate.didTapLocation(for: character)
    }


}
