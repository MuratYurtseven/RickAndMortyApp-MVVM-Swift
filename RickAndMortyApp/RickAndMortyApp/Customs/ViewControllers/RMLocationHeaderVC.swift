//
//  RMLocationHeaderVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 25.12.2023.
//

import UIKit

class RMLocationHeaderVC: UIViewController {
    
    let typeLabel = RMSecondaryTitleLabel(fontSize: 25)
    let dimensionLabel = RMSecondaryTitleLabel(fontSize: 25)
    let residentsLabel = RMSecondaryTitleLabel(fontSize: 25)
    let createdLabel = RMSecondaryTitleLabel(fontSize: 25)
    
    var views : [UIView] = []
    
    var location : LocationResult!
    
    init(location: LocationResult) {
        super.init(nibName:nil, bundle: nil)
        self.location = location
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layoutUI()
    }
    
    private func layoutUI(){
        
        views = [typeLabel,dimensionLabel,createdLabel,residentsLabel]
        
        for viewItem in views {
            view.addSubview(viewItem)
        }
        
        let padding : CGFloat = 20
        let textPadding : CGFloat = 12
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            typeLabel.heightAnchor.constraint(equalToConstant: 27),
            
            dimensionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: textPadding),
            dimensionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dimensionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dimensionLabel.heightAnchor.constraint(equalToConstant: 27),
            
            createdLabel.topAnchor.constraint(equalTo: dimensionLabel.bottomAnchor, constant: 8),
            createdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            createdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            createdLabel.heightAnchor.constraint(equalToConstant: 27),
            
            residentsLabel.topAnchor.constraint(equalTo: createdLabel.bottomAnchor, constant: 40),
            residentsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            residentsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            residentsLabel.heightAnchor.constraint(equalToConstant: 27),
        ])
        
    }
    
    private func configure(){
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = .secondarySystemBackground

        typeLabel.text = location.type
        dimensionLabel.text = location.dimension
        createdLabel.text = "Created at \(location.created.convertToDisplayFormat())"
        residentsLabel.text = "Some Example Residents"
    }
    


}
