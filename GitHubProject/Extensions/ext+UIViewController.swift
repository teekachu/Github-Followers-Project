//
//  ext+UIViewController.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/15/20.
//

//import Foundation
import UIKit   // (includes foundation)
import SafariServices

fileprivate var containerView: UIView! // file private restricts access to only entity within the same file. ie, accessing this from UIViewController

extension UIViewController{
    
    func presentGFalertOnMainThread(title: String, message: String, buttonTitle: String){
        
        DispatchQueue.main.async {

            let alertVC = GFAlertVC(title: title, detail: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve // fade in
            self.present(alertVC, animated: true)
            
        }
    }
    
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds) // whole screen
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0 // transparentcy
        
        UIView.animate(withDuration: 0.25) {  // add the animation
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    // since we are calling it from a bacground thread in followersListVC, we have to move it to the main thread.
    func dismissLoadingVIew(){
        DispatchQueue.main.async {
            guard self == self else{return }
            
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    func showEmptyStateView(with message: String, in view: UIView){
        let emptyStateview = GFemptyStateView(message: message)
        emptyStateview.frame = view.bounds
        view.addSubview(emptyStateview)
    }
    
    
    func presentSafariVC(with url: URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
}






