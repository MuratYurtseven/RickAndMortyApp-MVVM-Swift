//
//  RMCharacterModelView.swift
//  RickAndMortyApp
//
//  Created by Murat on 27.12.2023.
//

import UIKit

class RMCharacterModelView: UIViewController {
    
    enum Section {
        case main
    }
    var dataSource : UICollectionViewDiffableDataSource<Section,Character>!
    var characterResult : [Character] = []
    var hasMoreFollowers = true
    
    func getCharactes(page:Int,completed: @escaping(Result<[Character],RMError>) -> Void){
        NetworkManager.shared.getCharacters(page: page) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let characters):
                if characters.results.count < 20{
                    self.hasMoreFollowers = false
                }
                self.characterResult.append(contentsOf: characters.results)
                self.updateData(on: characterResult)
                completed(.success(self.characterResult))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func configureDataSource(in collectionView:UICollectionView){
        dataSource = UICollectionViewDiffableDataSource<Section,Character>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, character)-> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCell.resuseId, for: indexPath) as! CharactersCell
            cell.set(character: character)
            return cell
        })
    }
    
    func updateData(on characters : [Character]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Character>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(characters)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView) -> Bool{
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            return true
        } else {
            return false
        }
        
    }
    

}
