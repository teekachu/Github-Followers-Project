//
//  followerListVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/15/20.
//

import UIKit

class followerListVC: UIViewController {
    
    var username: String!
    var collectionView : UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureViewController()
        getFollowers()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true) // always call super when you are overriding
        //        navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    
    func configureViewController(){
        
        view.backgroundColor = .systemBackground
        //        navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureCollectionView(){
        
        // initialize
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemTeal
        // reguster the collectionview for use , use same reuseID from followersCell(static)
        collectionView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuseID)
    }
    
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout{
        let width = view.bounds.width // total width of screen. regardless of what phone it is
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let totalAvailableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = totalAvailableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
    
        return flowLayout
    }
    
    
    func getFollowers(){
        //new way using Results<>
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result{
            
            case.failure(let error):
                self.presentGFalertOnMainThread(title: "Bad stuff Happend", message: error.rawValue, buttonTitle: "Shitt!!")
                
            case .success(let followers):
                print("Followers.count: \(followers.count)")
                print(followers)
            }
        }
        
        //        NetworkManager.shared.getFollowers(for: username, page: 1) { (followersSuccessful, errorMSG) in  //param can be whatever we want
        //            guard let followers = followersSuccessful else{
        //                self.presentGFalertOnMainThread(title: "Bad stuff Happend", message: errorMSG!.rawValue, buttonTitle: "Shitt!!")
        //                return
        //            }
        //
        //            print("Followers.count: \(followers.count)")
        //            print(followers)
        //        }
    }
    

}
