//
//  RMCharactersVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 20.12.2023.
//

import UIKit



class RMCharactersVC: UIViewController {
    
    enum Section {
        case main
    }
    let CharacterViewModel = RMCharactersViewModel()
    var collectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section,Character>!
    var charactersList: [Character] = []
    var filteredCharacterList : [Character] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        getCharacters(page: page)
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in:view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CharactersCell.self, forCellWithReuseIdentifier: CharactersCell.resuseId)
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }

    
    func getCharacters(page:Int){
        showLoadingView()
        NetworkManager.shared.getCharacters(page: page) {[weak self] result in
            guard let self = self else {return}
            self.dismissLoading()
            switch result {
            case .success(let character):
                if character.results.count < 20{
                    self.hasMoreFollowers = false
                }
                self.charactersList.append(contentsOf:character.results)
                self.updateData(on: charactersList)
            case .failure(let error):
                self.presentRMAlertMessageOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
    
    
    func configureDataSource(){
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
}

extension RMCharactersVC : UICollectionViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else {return}
            page += 1
            getCharacters(page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activityArray = isSearching ? filteredCharacterList : charactersList
        
        let character = activityArray[indexPath.item]
        
        let destinationVC = RMCharacterDetailVC(gotCharacter: character)

        let navigationController = UINavigationController(rootViewController: destinationVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        
    }
    
}

extension RMCharactersVC : UISearchResultsUpdating,UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: charactersList)
            isSearching = false
            return
        }
        isSearching = true
        filteredCharacterList = charactersList.filter({$0.name.lowercased().contains(filter.lowercased())})
        updateData(on: filteredCharacterList)
    }
    
}
