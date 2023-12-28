//
//  RMFavoriteViewModel.swift
//  RickAndMortyApp
//
//  Created by Murat on 28.12.2023.
//

import Foundation
import UIKit

class RMFavoriteViewModel{
    
    var favoritedCharacters : [Character] = []
    
    func getCharacters(completed:@escaping(Result<[Character],RMError>) -> Void){
        PersistanceManager.retrieveFavorites { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    completed(.failure(.emptyCharactersList))
                }
                else {
                    self.favoritedCharacters = favorites
                    completed(.success(self.favoritedCharacters))

                }
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func numberOfRowsInSection()-> Int{
        return favoritedCharacters.count
    }
    
    func cellForRowAt(in tableView:UITableView,with indexPath :IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId) as! FavoriteCell
        let favorite = favoritedCharacters[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func editingStyle(in tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle,with indexPath :IndexPath,completed: @escaping(RMError?)-> Void){
        guard editingStyle == .delete else {return}
        let favorite = favoritedCharacters[indexPath.row]
        favoritedCharacters.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with:.left)
        PersistanceManager.updateWith(character: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else {return}
            guard let error = error else {return}
            completed(error)            
        }
        
    }
}
