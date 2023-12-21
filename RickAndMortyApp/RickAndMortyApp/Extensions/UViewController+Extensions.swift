//
//  UViewController+Extensions.swift
//  RickAndMortyApp
//
//  Created by Murat on 21.12.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentRMAlertMessageOnMainThread(title:String,message:String){
        DispatchQueue.main.async {
            let alertVC = RMAlertVC(alerTitle: title, message: message)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
}
