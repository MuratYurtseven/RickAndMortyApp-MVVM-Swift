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
    let locationView = UIView()
    let originView = UIView()
    let dateLabel = RMBodyLabel(textAligment: .center)
    
    var views: [UIView] = []
    
    
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
        add(childVC: RMCharacterHeaderVC(character: gotCharacter), to: headerView)
        add(childVC: RMLocationVC(character: gotCharacter), to: locationView)
        add(childVC: RMOriginVC(character: gotCharacter), to: originView)
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
