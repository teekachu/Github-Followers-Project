//
//  GFItemInfoVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/20/20.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    let stackview = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton(frame: .zero)
    var user: user!

    
    init(user: user){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        addSubview()
        configureStackview()
        layoutUI()
    }
    

    private func configureBackgroundView(){
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground // gray ish
    }
    
    
    private func addSubview(){
        view.addSubview(stackview)
        view.addSubview(actionButton)
    }
    
    
    private func configureStackview(){
        stackview.axis = .horizontal
        stackview.distribution = .equalSpacing
        stackview.addArrangedSubview(itemInfoViewOne)
        stackview.addArrangedSubview(itemInfoViewTwo)
    }
    
    
    private func layoutUI(){
        stackview.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackview.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }

}
