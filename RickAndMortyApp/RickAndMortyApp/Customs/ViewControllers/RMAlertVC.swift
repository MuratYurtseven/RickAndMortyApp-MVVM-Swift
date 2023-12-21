//
//  RMAlertVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 21.12.2023.
//

import UIKit

class RMAlertVC: UIViewController {

    let containerView = RMContainerView(backgroundColor: .systemBackground, cornerRadius: 16, borderWidth: 2, borderColor: .white)
    let titleLabel = RMTitleLabel(textAligment: .center, fontSize: 20)
    let messageLabel = RMBodyLabel(textAligment: .center)
    let okButton = RMButton(backgroundColor: .systemPink, title: "Ok")
    
    var views: [UIView] = []
    
    var alertTitle : String?
    var message : String?
    
    init(alerTitle:String,message:String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alerTitle
        self.message = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAlertVC()

        
    }
    
    private func configureAlertVC(){
        view.addSubview(containerView)
        let padding: CGFloat = 20
        views = [titleLabel,messageLabel,okButton]
        for view in views{
            containerView.addSubview(view)
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding).isActive = true
            
            view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding).isActive = true
        }
        
        titleLabel.text = alertTitle ?? "Something went wrong"
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        okButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            
            okButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            okButton.heightAnchor.constraint(equalToConstant: 44),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -12)
        ])
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}
