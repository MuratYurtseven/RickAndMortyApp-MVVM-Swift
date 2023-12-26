//
//  UViewController+Extensions.swift
//  RickAndMortyApp
//
//  Created by Murat on 21.12.2023.
//

import Foundation
import UIKit

fileprivate var containerView : UIView!
extension UIViewController {

    func presentRMAlertMessageOnMainThread(title:String,message:String){
        DispatchQueue.main.async {
            let alertVC = RMAlertVC(alerTitle: title, message: message)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView(){
        
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.45) {
            containerView.alpha = 0.85}
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemOrange
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)])
        
        activityIndicator.startAnimating()
        }
    
    
    func dismissLoading(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
}
