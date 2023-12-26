//
//  LocationResponse.swift
//  RickAndMortyApp
//
//  Created by Murat on 25.12.2023.
//

import Foundation

struct LocationResponse : Codable{
    
    var info : Info
    var results : [LocationResult]
    
}
