//
//  SearchVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/14/20.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoimageView = UIImageView()
    let usernameTextField = GFTextfield()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    // computed property
    var isUserNameEntered: Bool {
        return !usernameTextField.text!.isEmpty // if empty(true), then its NOT entered, so false.
    }
    
    // logo names to avoid stringly typed - which is dangerous
    let ghlogo = "gh-logo"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground // systemBackground color will adapt to light/dark mode
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyBoardGesture()
    }
    
    
    // called EVERYTIME the view pops up. instead of viewDidLoad is just initial load
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        usernameTextField.delegate = self
    }
    
    
    // functions
    func createDismissKeyBoardGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing)) // basically resign first responder status
        view.addGestureRecognizer(tap)
        
    }
    
    
    @objc func pushToFollowersListVC(){
        guard isUserNameEntered else { // only pop into the other VC if field is NOT empty
//            print("no username")
            
            // TODO: alert here
            // cmd + ctrl + space bar -> emoji menu
            presentGFalertOnMainThread(title: "Empty Username", message: "Please enter a username, we need to know who to look for 🤗", buttonTitle: "Sure thing")
            return
            
        }
        
        let fvc = FollowerListVC()
        fvc.username = usernameTextField.text
        fvc.title = usernameTextField.text
        //        fvc.navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(fvc, animated: true)
        
    }
    
    
    // MARK: UI stuff
    func configureLogoImageView(){
        view.addSubview(logoimageView)
        logoimageView.translatesAutoresizingMaskIntoConstraints = false
        logoimageView.image = UIImage(named: ghlogo)
        
        NSLayoutConstraint.activate([
            // normally want 4 constraints per object, normally height,width, x + y cords
            logoimageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoimageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), // in the middle of Y
            logoimageView.heightAnchor.constraint(equalToConstant: 200),
            logoimageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    // MARK: USE - NEGATIVE numbers for : Trailing and Bottom
    func configureTextField(){
        view.addSubview(usernameTextField)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoimageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCallToActionButton(){
        view.addSubview(callToActionButton)
        
        // adding target
        callToActionButton.addTarget(self, action: #selector(pushToFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


// MARK: Good practice to add as extension
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // print("didTapreturn")
        pushToFollowersListVC()
        return true
    }
}


