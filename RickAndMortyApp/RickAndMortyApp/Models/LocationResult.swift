//
//  LocationResult.swift
//  RickAndMortyApp
//
//  Created by Murat on 25.12.2023.
//

import Foundation

struct LocationResult : Codable{
    
    var id : Int
    var name : String
    var type : String
    var dimension : String
    var residents : [String]
    var url : String
    var created : String
}
