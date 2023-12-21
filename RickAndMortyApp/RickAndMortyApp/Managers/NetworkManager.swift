//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Murat on 21.12.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://rickandmortyapi.com/api"
    
    private init(){ }
    
    func getCharacters(page: Int,comleted : @escaping(Character?,String?) -> Void){
        let endPoint = baseUrl + "/character/?page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            comleted(nil,"Url error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data,response,error in
            if let _ = error {
                comleted(nil,"error task")
                return
            }
            
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                comleted(nil,"response error")
                return
            }
            
            guard let data = data else {
                comleted(nil,"data error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode(Character.self, from: data)
                comleted(characters,nil)
            }
            catch let catchedError {
                print(catchedError)
                comleted(nil,"data catched error")
            }
        }
        task.resume()
    }
}
