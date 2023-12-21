//
//  RMLocationsVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 20.12.2023.
//

import UIKit

class RMLocationsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
      
    }
    
    private func configureViewController(){
        view.backgroundColor = .systemPink
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
