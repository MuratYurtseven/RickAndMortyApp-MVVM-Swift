//
//  PersistanceManager.swift
//  RickAndMortyApp
//
//  Created by Murat on 24.12.2023.
//

import Foundation
import UIKit

enum PersistancActionType{
    case add,remove
}

enum PersistanceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys{
        static let characters = "characters"
    }
    
    
    static func retrieveFavorites(completed: @escaping(Result<[Character],RMError>) -> Void){
        
        guard let charactersData = defaults.object(forKey: Keys.characters) as? Data else {
            completed(.success([]))
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let characters = try decoder.decode([Character].self, from: charactersData)
            completed(.success(characters))
        }
        catch {
            completed(.failure(.unableToFavorited))
        }
    }
    
    static func save(character: [Character]) -> RMError?{
        do {
            let endocer = JSONEncoder()
            let endocerFavorites = try endocer.encode(character)
            defaults.set(endocerFavorites, forKey: Keys.characters)
            return nil
        }
        catch{
            return .unableToFavorited
        }
    }
    
    static func updateWith(character:Character,actionType:PersistancActionType,completed:@escaping(RMError?) -> Void){
        retrieveFavorites { result in
            switch result {
            case .success(let characters):
                var retirevedCharacter = characters
                switch actionType {
                case .add:
                    guard !retirevedCharacter.contains(character) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retirevedCharacter.append(character)
                case .remove:
                    retirevedCharacter.removeAll{$0.id == character.id}
                }
                completed(save(character: retirevedCharacter))
            case .failure(let error):
                completed(error)
            }
        }
    }
}
