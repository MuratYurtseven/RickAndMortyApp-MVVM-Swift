//
//  RMFavoritesVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 20.12.2023.
//

import UIKit

class RMFavoritesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()

    }
    
    private func configureViewController(){
        view.backgroundColor = .systemYellow
        navigationController?.navigationBar.prefersLargeTitles = true
    }



}
