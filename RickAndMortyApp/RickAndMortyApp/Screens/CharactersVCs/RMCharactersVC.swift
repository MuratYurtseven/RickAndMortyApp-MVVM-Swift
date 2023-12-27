//
//  RMCharactersVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 20.12.2023.
//

import UIKit



class RMCharactersVC: UIViewController {

    var collectionView : UICollectionView!
    var viewModel = RMCharacterModelView()
    var charactersList: [Character] = []
    var filteredCharacterList : [Character] = []
    var page = 1
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        
    }
    
    private func setup(){
        
        configureViewController()
        configureSearchController()
        getData(page: page)
        configureCollectionView()
        viewModel.configureDataSource(in: collectionView)
    }
    

    private func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func getData(page:Int){
        showLoadingView()
        viewModel.getCharactes(page: page) {[weak self] result in
            guard let self = self else {return}
            self.dismissLoading()
            switch result {
            case .success(let characters):
                self.charactersList = characters
            case .failure(let error):
                self.presentRMAlertMessageOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
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

}

extension RMCharactersVC : UICollectionViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if viewModel.scrollViewDidEndDragging(scrollView: scrollView){
            guard viewModel.hasMoreFollowers else {return}
            page += 1
            getData(page: page)

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
            viewModel.updateData(on: charactersList)
            isSearching = false
            return
        }
        isSearching = true
        filteredCharacterList = charactersList.filter({$0.name.lowercased().contains(filter.lowercased())})
        viewModel.updateData(on: filteredCharacterList)
    }
    
}
