//
//  RMLocationDetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Murat on 28.12.2023.
//

import Foundation

class RMLocationDetailViewModel{

    func getCharacter(characterUrl :String,completed :@escaping(Result<Character,RMError>) -> Void){
        NetworkManager.shared.singleCharacter(chracterUrl: characterUrl) {Result in
            switch Result {
            case .success(let character):
                completed(.success(character))
            case .failure(let error):
                completed(.failure(error))
            }
        }

    }
}
