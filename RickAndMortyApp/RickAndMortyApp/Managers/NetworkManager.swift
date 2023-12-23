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
}
