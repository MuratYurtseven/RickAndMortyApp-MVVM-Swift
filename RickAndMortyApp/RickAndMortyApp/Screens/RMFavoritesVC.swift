//
//  RMFavoritesVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 20.12.2023.
//

import UIKit

class RMFavoritesVC: UIViewController {

    let tableView = UITableView()
    var favoritedCharacters : [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getCharacters()
    }
    
    private func configureViewController(){
        view.backgroundColor = .systemYellow
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
    }
    
    private func getCharacters(){
        PersistanceManager.retrieveFavorites { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    presentRMAlertMessageOnMainThread(title: "Empty Favorited List", message: "Please favorited some characters😀.")
                }
                else {
                    self.favoritedCharacters = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentRMAlertMessageOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }

}

extension RMFavoritesVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritedCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId) as! FavoriteCell
        let favorite = favoritedCharacters[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favoritedCharacters[indexPath.row]
        let destVC = RMCharacterDetailVC()
        destVC.gotCharacter = favorite
        
        let navigationController = UINavigationController(rootViewController: destVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let favorite = favoritedCharacters[indexPath.row]
        favoritedCharacters.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with:.left)
        PersistanceManager.updateWith(character: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else {return}
            guard let error = error else {return}
            self.presentRMAlertMessageOnMainThread(title: "Unable to remove", message: error.rawValue)
            
        }
        
    }
    
}
