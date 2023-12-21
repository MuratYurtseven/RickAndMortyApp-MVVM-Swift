//
//  RMCharactersVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 20.12.2023.
//

import UIKit

class RMCharactersVC: UIViewController {

    var charactersList: [Results] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
        NetworkManager.shared.getCharacters(page: 1) { characters, error in
            guard let characters = characters else {
                self.presentRMAlertMessageOnMainThread(title: "Hata", message: error!)
                return
            }
            if let listResult = characters.results {
                for result in listResult{
                    self.charactersList.append(result)
                    
                }
            }
            
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for character in charactersList{
            print(character.name!)
        }
        
    }

    private func configureViewController(){
        view.backgroundColor = .systemGreen
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

    


}
