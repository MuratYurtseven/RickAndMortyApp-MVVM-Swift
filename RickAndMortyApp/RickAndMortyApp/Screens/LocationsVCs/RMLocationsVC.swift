//
//  RMLocationsVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 20.12.2023.
//

import UIKit

class RMLocationsVC: UIViewController {

    let tableView  = UITableView()
    var locations : [LocationResult] = []
    var page = 1
    var hasMoreLocations = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocations(page: page)
    }
    
    
    private func configureViewController(){
        view.backgroundColor = .systemPink
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 45
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.reuseId)
        
    }
    
    private func getLocations(page:Int){
        NetworkManager.shared.getLocations(page: page) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let lResponse):
                if lResponse.results.count < 20 {
                    self.hasMoreLocations = false
                }
                self.locations.append(contentsOf: lResponse.results)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            case .failure(let error):
                self.presentRMAlertMessageOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }

}

extension RMLocationsVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.reuseId) as! LocationCell
        let locaiton = locations[indexPath.row]
        
        cell.set(location: locaiton)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        let destVC = RMLocationDetailVC(gotLocation: location)
        
        let navigationController = UINavigationController(rootViewController: destVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > contentHeight - height{
            guard hasMoreLocations else { return }
            page += 1
            getLocations(page: page)
        }
    }
    
    
}
