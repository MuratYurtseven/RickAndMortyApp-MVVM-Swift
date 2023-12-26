//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Murat on 21.12.2023.
//

import Foundation
import UIKit

class NetworkManager {
    let cache = NSCache<NSString,UIImage>()
    static let shared = NetworkManager()
    let baseUrl = "https://rickandmortyapi.com/api"
    
    private init(){ }
    
    func getCharacters(page: Int,comleted : @escaping(Result<CharacterResponse,RMError>) -> Void){
        let endPoint = baseUrl + "/character/?page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            comleted(.failure(.inavailedPage))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data,response,error in
            if let _ = error {
                comleted(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                comleted(.failure(.invailedResponse))
                return
            }
            
            guard let data = data else {
                comleted(.failure(.invailedData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode(CharacterResponse.self, from: data)
                comleted(.success(characters))
            }
            catch let catchedError {
                print(catchedError)
                comleted(.failure(.invailedData))
            }
        }
        task.resume()
    }
    
    func getLocations(page : Int,completed : @escaping(Result<LocationResponse,RMError>) -> Void){
        let endPoint = baseUrl + "/location?page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.inavailedPage))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data,response,error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completed(.failure(.invailedResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invailedData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let location = try decoder.decode(LocationResponse.self, from: data)
                completed(.success(location))
            }
            catch {
                completed(.failure(.invailedData))
            }
            
        }
        task.resume()
    }
    
    func singleCharacter(chracterUrl:String,completed: @escaping(Result<Character,RMError>) -> Void){
        
        guard let url = URL(string: chracterUrl) else {
            completed(.failure(.inavailedPage))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data,response,error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return}
            
            guard let response = response as? HTTPURLResponse ,response.statusCode == 200 else {
                completed(.failure(.invailedResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invailedData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let character = try decoder.decode(Character.self, from: data)
                completed(.success(character))
            }
            catch {
                completed(.failure(.invailedData))
            }
        }
        task.resume()
    }
    
    func getSingeleLocation(url :String, completed: @escaping(Result<LocationResult,RMError>) -> Void){
        
        guard let url = URL(string: url) else {
            completed(.failure(.inavailedPage))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data,response,error in
            
            if let  _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completed(.failure(.invailedResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invailedData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let location = try decoder.decode(LocationResult.self, from: data)
                completed(.success(location))
            }
            catch {
                completed(.failure(.invailedData))
            }
            
        }
        task.resume()
    }
        
}
