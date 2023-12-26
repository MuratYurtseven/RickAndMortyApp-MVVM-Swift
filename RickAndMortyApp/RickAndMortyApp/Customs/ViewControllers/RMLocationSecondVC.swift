//
//  RMLocationSecondVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 26.12.2023.
//

import UIKit

class RMLocationSecondVC: UIViewController {
    var collectionView : UICollectionView!
    var chracters : [Character] = []
    
    init(chracters: [Character]) {
        super.init(nibName: nil, bundle: nil)
        self.chracters.append(contentsOf: chracters)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroudColor()
        configureCollectionView()
        for item in chracters{
            print(item)
            print("******")
        }
    }
    
    private func configureBackgroudColor(){
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemBackground
    }
    
    private func configureCollectionView(){
        
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: UIHelper.createOneColumnFlowLayout(in: self.view))
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharactersCell.self, forCellWithReuseIdentifier: CharactersCell.resuseId)
    }
    

}

extension RMLocationSecondVC : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chracters.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCell.resuseId, for: indexPath) as! CharactersCell
        cell.set(character: chracters[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = chracters[indexPath.row]
        let destVC = RMCharacterDetailVC(gotCharacter: character)
        
        let navigationController = UINavigationController(rootViewController: destVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        
    }
    
}
