//
//  Results.swift
//  RickAndMortyApp
//
//  Created by Murat on 21.12.2023.
//

import Foundation

class Results : Codable {
    
    var id : Int?
    var name : String?
    var status : String?
    var species : String?
    var type : String?
    var gender : String?
    var origin : Origin?
    var location : Location?
    var image : String?
    var episode : [String]?
    var url : String?
    var created : String?
    
    init(id: Int, name: String, status: String,species : String ,type: String, gender: String,origin: Origin,location: Location,image: String, episode: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
    
}
