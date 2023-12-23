//
//  RMCharacterDetailVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 23.12.2023.
//

import UIKit

class RMCharacterDetailVC: UIViewController {
    
    var gotCharacter : Character!
    let headerView = UIView()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewController()
        layoutUI()
    }
    
    private func addViewsToView(){
        add(childVC: RMCharacterHeaderVC(character: gotCharacter), to: headerView)
    }
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationItem.title = gotCharacter.name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(dismissTapped))
        navigationItem.leftBarButtonItem = backButton
        addViewsToView()
    }
    
    @objc func dismissTapped(){
        dismiss(animated: true)
    }
    
    private func layoutUI(){
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 280 )
        ])
    }
    
    private func add(childVC : UIViewController,to containerView : UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}
