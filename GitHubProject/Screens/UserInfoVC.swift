//
//  UserInfoVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/19/20.
//

import UIKit


// To set up communication between the twp itemInfoVCs ( contains the button) and the userInfoVC ( the main VC that will call / make actions)
protocol GithubProfileTappable: class{
    func didTapGithubProfile(for user: user) // what happens when i tap the first button
}

protocol GithubFollowersTappable: class{
    func didTapGetFollowers(for user: user)  // what happens when i tap the second button
}

class UserInfoVC: UIViewController {
    weak var delegate: FollowerListVCDeligate!
    
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
                DispatchQueue.main.async {
                    self.configureUIElements(with: user) }
                
            case .failure(let error):
                self.presentGFalertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok") }
        }
    }
    
    
    func configureUIElements(with user: user){
        
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self   // userInfoVC is listening to repoItemVC
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self   // userInfoVC is listening to the followerItemVC
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "Github since \(user.created_at.convertToDisplayFormat())"
        
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


extension UserInfoVC: GithubProfileTappable{ // conform to deligate , with commands to pass
    func didTapGithubProfile(for user: user) {
        // Show safari VC
        //        print("Github Profile button tapped, Show safari VC")
        guard let url = URL(string: user.html_url) else{
            presentGFalertOnMainThread(title: "Invalid URL", message: GFError.urlInvalid.rawValue, buttonTitle: "Okay")
            return
        }
        presentSafariVC(with: url)
    }
}


extension UserInfoVC: GithubFollowersTappable{
    func didTapGetFollowers(for user: user) {
        //1. check for whether user have followers
        guard user.followers != 0 else{
            presentGFalertOnMainThread(title: "no followers", message: "This user has no followers😔 ", buttonTitle: "Too bad")
            return }
        //2. go to followers list screen and refresh for new users
        delegate.didRequestFollowers(for: user.login)
        //3. dismiss this VC
        dismissVC()
        //        print("Followers button tapped, Refresh for new users")
    }
}

