//
//  RMCharacterDetailVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 23.12.2023.
//

import UIKit

protocol RMCharacterDetailVCDelegate: class{
    func didTapFavorited(for character:Character)
    func didTapLocation(for character:Character)
    func didTapOrigin(for character:Character)
}

class RMCharacterDetailVC: UIViewController {
    
    var gotCharacter : Character!
    let headerView = UIView()
    let locationView = UIView()
    let originView = UIView()
    let dateLabel = RMBodyLabel(textAligment: .center)
    
    var views: [UIView] = []
    
    init(gotCharacter:Character){
        super.init(nibName: nil, bundle: nil)
        self.gotCharacter = gotCharacter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(gotCharacter.created)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewController()
        layoutUI()
    }
    
    private func addViewsToView(){
        
        let characterHeaderVC = RMCharacterHeaderVC(character: gotCharacter)
        characterHeaderVC.delegate = self
        add(childVC: characterHeaderVC, to: headerView)
        
        let locationVC = RMLocationVC(character: gotCharacter)
        locationVC.delegate = self
        add(childVC:locationVC , to: locationView)
        
        let originVC = RMOriginVC(character: gotCharacter)
        originVC.delegate = self
        add(childVC: originVC, to: originView)
    }
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationItem.title = gotCharacter.name
        navigationController?.navigationBar.prefersLargeTitles = true
        dateLabel.text = "Created at \(gotCharacter.created.convertToDisplayFormat())"
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(dismissTapped))
        navigationItem.leftBarButtonItem = backButton
        addViewsToView()
    }
    
    @objc func dismissTapped(){
        dismiss(animated: true)
    }
    
    private func layoutUI(){
        views = [headerView,locationView,originView,dateLabel]
        let padding : CGFloat = 20
        for itemView in views{
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        headerView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 280 ),
            
            locationView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            locationView.heightAnchor.constraint(equalToConstant: 100),
            
            originView.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: padding),
            originView.heightAnchor.constraint(equalToConstant: 100),
            
            dateLabel.topAnchor.constraint(equalTo: originView.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func add(childVC : UIViewController,to containerView : UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}

extension RMCharacterDetailVC : RMCharacterDetailVCDelegate{
    
    func didTapFavorited(for character: Character) {
        PersistanceManager.updateWith(character: character, actionType: .add) {[weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                self.presentRMAlertMessageOnMainThread(title: "Success!", message: "You have successfully favorited this user.")
                return
            }
            self.presentRMAlertMessageOnMainThread(title: "Something went wrong", message: error.rawValue)
        }
    }
    
    func didTapLocation(for character: Character) {
        NetworkManager.shared.getSingeleLocation(url: character.location.url) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let location):
                DispatchQueue.main.async {
                    let destVC = RMLocationDetailVC(gotLocation: location)
                    
                    let navigationController = UINavigationController(rootViewController: destVC)
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true)
                }

            case .failure(let error):
                self.presentRMAlertMessageOnMainThread(title: "Something went wrong.", message: error.rawValue)
            }
        }
    }
    
    func didTapOrigin(for character: Character) {
        NetworkManager.shared.getSingeleLocation(url: character.origin.url) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let location):
                DispatchQueue.main.async {
                    let destVC = RMLocationDetailVC(gotLocation: location)
                    
                    let navigationController = UINavigationController(rootViewController: destVC)
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true)
                }

            case .failure(let error):
                self.presentRMAlertMessageOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
    
}
