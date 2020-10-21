//
//  UserInfoVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/19/20.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    override func viewDidLoad() {
        configureViewController()
        getUserInfoNetworkCall()
        layoutUI()
    }
    
    
    func configureViewController(){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func getUserInfoNetworkCall(){
        NetworkManager.shared.getUserInfo(for: username) {[weak self] (result) in
            guard let self = self else{return}
            switch result{
            
            case .success(let user):
                //                print(user)
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemVC(user: user), to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemVC(user: user), to: self.itemViewTwo)
                    self.dateLabel.text = "Github since \(user.created_at.convertToDisplayFormat())"
                    
                }
                
            case .failure(let error):
                self.presentGFalertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func layoutUI(){
        itemViews += [headerView, itemViewOne, itemViewTwo, dateLabel]
        for eachView in itemViews{
            view.addSubview(eachView)
            eachView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
    
}

