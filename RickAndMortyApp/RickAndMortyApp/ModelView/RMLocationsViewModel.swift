//
//  RMLocationsViewModel.swift
//  RickAndMortyApp
//
//  Created by Murat on 27.12.2023.
//

import Foundation
import UIKit

class RMLocationsViewModel {
    
    var locationResult : [LocationResult] = []
    var hasMoreFollowers = true
    
    func getLocations(page:Int,completed: @escaping(Result<[LocationResult],RMError>) -> Void){
        NetworkManager.shared.getLocations(page: page) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let locations):
                if locations.results.count < 20 {
                    self.hasMoreFollowers = false
                }
                self.locationResult.append(contentsOf: locations.results)
                completed(.success(locationResult))
            case .failure(let error):
                completed(.failure(error))
            }
            
        }
    }
    
    func numberOfRowsInSection() -> Int{
        return locationResult.count
    }
    
    func cellForRowAt(in tableView: UITableView,with indeksPath:IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.reuseId) as! LocationCell
        let locaiton = locationResult[indeksPath.row]
        
        cell.set(location: locaiton)
        return cell
    }
    
    func scrollViewDidEndDragging(in scrollView:UIScrollView) -> Bool {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > contentHeight - height{
            return true
        } else {
            return false
        }
    }
}
