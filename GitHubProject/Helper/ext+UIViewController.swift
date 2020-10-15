//
//  ext+UIViewController.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/15/20.
//

//import Foundation
import UIKit   // (includes foundation)

extension UIViewController{
    
    func presentGFalertOnMainThread(title: String, message: String, buttonTitle: String){
        
        DispatchQueue.main.async {

            let alertVC = GFAlertVC(title: title, detail: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve // fade in
            self.present(alertVC, animated: true)
            
        }
    }
}

