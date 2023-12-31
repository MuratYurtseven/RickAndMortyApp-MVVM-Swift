//
//  RMFavoritesVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 20.12.2023.
//

import UIKit

class RMFavoritesVC: UIViewController {
    
    var viewModel = RMFavoriteViewModel()
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
        viewModel.getCharacters {[weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let characters):
                self.favoritedCharacters = characters
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            case .failure(let error):
                self.presentRMAlertMessageOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }

}

extension RMFavoritesVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRowAt(in: tableView, with: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favoritedCharacters[indexPath.row]
        let destVC = RMCharacterDetailVC(gotCharacter: favorite)
        
        let navigationController = UINavigationController(rootViewController: destVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.editingStyle(in: tableView, commit: editingStyle, with: indexPath) {[weak self] error in
            guard let self = self else {return}
            guard let error = error else {return}
            self.presentRMAlertMessageOnMainThread(title: "Something went wrong", message: error.rawValue)
        }
        
    }
    
}
