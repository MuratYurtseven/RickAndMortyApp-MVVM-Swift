//
//  RMLocationDetailVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 25.12.2023.
//

import UIKit

class RMLocationDetailVC: UIViewController {
    
    var gotLocation : LocationResult!
    let headerVC = UIView()
    let collectionVC = UIView()
    var characterList : [Character] = []
    
    init(gotLocation: LocationResult) {
        super.init(nibName: nil, bundle: nil)
        self.gotLocation = gotLocation
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        addChractersToList()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addViewToMainView()
    }
    
    
    
    private func configureViewController(){
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(dismissVC))
        navigationItem.leftBarButtonItem = backButton
        view.backgroundColor = .systemBackground
        navigationItem.title = gotLocation.name
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func addViewToMainView(){
        let LocatioHeaderVC = RMLocationHeaderVC(location: gotLocation)
        self.add(childVC: LocatioHeaderVC, to: self.headerVC)
        
        let LocationCollectionVC = RMLocationSecondVC(chracters: characterList)
        self.add(childVC: LocationCollectionVC, to: self.collectionVC)
        
    }
    
    private func layoutUI(){
        view.addSubview(headerVC)
        view.addSubview(collectionVC)
        headerVC.translatesAutoresizingMaskIntoConstraints = false
        collectionVC.translatesAutoresizingMaskIntoConstraints = false
        
        let padding : CGFloat = 20
        NSLayoutConstraint.activate([
            headerVC.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerVC.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            headerVC.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            headerVC.heightAnchor.constraint(equalToConstant: 200),
            
            collectionVC.topAnchor.constraint(equalTo: headerVC.bottomAnchor, constant: padding),
            collectionVC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            collectionVC.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            collectionVC.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
    
    func add(childVC : UIViewController,to containerView : UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    private func addChractersToList(){
        if gotLocation.residents.count == 0 {return}
        if gotLocation.residents.count>=1 && gotLocation.residents.count<=8{
            for characterUrlIndeks in 0...gotLocation.residents.count - 1{
                getCharacter(characterUrl: gotLocation.residents[characterUrlIndeks])
            }
            
        }
        if gotLocation.residents.count>=8{
            for characterUrlIndeks in 0...7{
                getCharacter(characterUrl: gotLocation.residents[characterUrlIndeks])
            }
        }
    }
    
    private func getCharacter(characterUrl :String){
        NetworkManager.shared.singleCharacter(chracterUrl: characterUrl) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let character):
                self.characterList.append(character)
            case .failure(let error):
                self.presentRMAlertMessageOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
}
