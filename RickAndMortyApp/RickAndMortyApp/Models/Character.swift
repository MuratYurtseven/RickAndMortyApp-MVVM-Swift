//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Murat on 22.12.2023.
//

import Foundation

struct Character : Codable , Hashable{
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin : Location
    var location : Location
    var image: String
    var episodes: [String]
    var url: String
    var created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender,image, url, created,origin,location
        case episodes = "episode"
            }
}
