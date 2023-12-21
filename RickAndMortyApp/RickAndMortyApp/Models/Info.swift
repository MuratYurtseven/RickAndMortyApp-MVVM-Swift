//
//  Info.swift
//  RickAndMortyApp
//
//  Created by Murat on 21.12.2023.
//

import Foundation

class Info : Codable {
    
    var count : Int?
    var pages : Int?
    var next : String?
    var prev : String?
    
    init(count: Int, pages: Int, next: String, prev: String) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}
