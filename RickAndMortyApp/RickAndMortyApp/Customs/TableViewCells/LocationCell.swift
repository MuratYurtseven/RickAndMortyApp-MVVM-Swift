//
//  LocationCell.swift
//  RickAndMortyApp
//
//  Created by Murat on 25.12.2023.
//

import UIKit

class LocationCell: UITableViewCell {

    static let reuseId = "LocationCell"
    let locationName = RMTitleLabel(textAligment: .left, fontSize: 22)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(location:LocationResult){
        locationName.text = location.name
    }
    
    private func configure(){
        addSubview(locationName)
        accessoryType = .disclosureIndicator
        
        let padding : CGFloat = 12
        
        NSLayoutConstraint.activate([
            locationName.centerYAnchor.constraint(equalTo: centerYAnchor),
            locationName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            locationName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            locationName.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
}
