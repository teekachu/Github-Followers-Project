//
//  GFAlertVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/15/20.
//

import UIKit

// custom alert window
class GFAlertVC: UIViewController {
    
    let containerView = GFAlertContainerView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let errorMessage = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String? // such as "okay" 
    
    let paddingValue: CGFloat = 20
    
    init(title: String, detail: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = title
        self.message = detail
        self.buttonTitle = buttonTitle
        
        configureContainerView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set UI.
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }
    
    
    // MARK: autolayout UI stuff
    private func configureContainerView(){

        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
        ])
    }
    
    
    private func configureTitleLabel(){
        
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong :( "
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: paddingValue),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: paddingValue),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -paddingValue),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    private func configureActionButton(){
        
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissContainerVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -paddingValue),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: paddingValue),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -paddingValue),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    @objc func dismissContainerVC() {
        dismiss(animated: true)
    }
    
    
    private func configureBodyLabel(){
        
        containerView.addSubview(errorMessage)
        errorMessage.text = message ?? "Unable to complete request"
        errorMessage.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            errorMessage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            errorMessage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: paddingValue),
            errorMessage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -paddingValue),
            errorMessage.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    
}
