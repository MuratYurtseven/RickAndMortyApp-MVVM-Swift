//
//  Origin.swift
//  RickAndMortyApp
//
//  Created by Murat on 21.12.2023.
//

import Foundation

class Origin : Codable {
    
    var name : String?
    var url : String?
    
    init(name:String,url:String){
        self.name = name
        self.url = url
    }
}
