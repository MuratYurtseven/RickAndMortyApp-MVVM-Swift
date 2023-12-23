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
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCharacters(page: page)
    }
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in:view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CharactersCell.self, forCellWithReuseIdentifier: CharactersCell.resuseId)
    }

    
    func getCharacters(page:Int){
        
        NetworkManager.shared.getCharacters(page: page) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let character):
                self.charactersList = character.results
                self.updateData()
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
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Character>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(charactersList)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
        
    }
    

}

