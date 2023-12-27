//
//  RMLocationsVC.swift
//  RickAndMortyApp
//
//  Created by Murat on 20.12.2023.
//

import UIKit

class RMLocationsVC: UIViewController {
    
    var viewModel = RMLocationsViewModel()
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
    
    private func getLocations(page: Int){
        viewModel.getLocations(page: page) {[weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let locationResults):
                self.locations = locationResults
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            case .failure(let error):
                self.presentRMAlertMessageOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 45
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.reuseId)
        
    }


}

extension RMLocationsVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return viewModel.cellForRowAt(in: tableView, with: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        let destVC = RMLocationDetailVC(gotLocation: location)
        
        let navigationController = UINavigationController(rootViewController: destVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if viewModel.scrollViewDidEndDragging(in: scrollView){
            guard viewModel.hasMoreFollowers else { return }
            page += 1
            getLocations(page: page)
        }
    }
    
    
}
