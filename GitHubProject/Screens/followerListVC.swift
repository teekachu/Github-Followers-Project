//
//  followerListVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/15/20.
//

import UIKit

protocol followerListVCDeligate: class{
    func didRequestFollowers(for username: String)
}

class followerListVC: UIViewController {
    var username: String!
    var collectionView : UICollectionView!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var pageCounter: Int = 1
    var hasMoreFollowrs = true // flip to false after certain condition
    var isSearching = false
    
    //     MARK: diffable
    // create main section of collection view , has to know about the Section and Items(list of Followers)
    enum Section {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        configureSearchController()
        getFollowers(username: username, page: pageCounter)
        configureDataSource()
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self  // set the deligate
        collectionView.backgroundColor = .systemBackground
        // reguster the collectionview for use , use same reuseID from followersCell(static)
        collectionView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuseID)
    }
    
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a user here"
        searchController.obscuresBackgroundDuringPresentation = false // this is what caused the gray to disspear and able to search and click on whichever avatar to open. 
        navigationItem.searchController = searchController
    }
    
    
    func getFollowers(username: String, page: Int){
        showLoadingView()   // loading screen
        //new way using Results<>
        NetworkManager.shared.getFollowers(for: username, page: pageCounter) {[weak self] result in
            //            #warning("call dismiss loading view")
            guard let self = self else{return} // new hack to get rid of the ? below
            self.dismissLoadingVIew()
            
            switch result{
            
            case.failure(let error):
                self.presentGFalertOnMainThread(title: "Bad stuff Happend", message: error.rawValue, buttonTitle: "Shitt!!")
                
            case .success(let followers):
                
                // check for followers
                if followers.count < 100 {
                    self.hasMoreFollowrs = false
                }
                
                self.followers.append(contentsOf: followers)  // same thing as followers.append()
                
                if followers.isEmpty{
                    let message = "This user doesn't have any followers, go follow them 😁"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                        return // get out of the function instead of updateData(). 
                    }
                }
                
                self.updateData(on: self.followers)
            //                print("Followers.count: \(followers.count)")
            //                print(followers)
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
    
    
    // MARK: diffable continued:
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCell.reuseID, for: indexPath) as? FollowersCell
            cell?.set(follower: follower) // for every follower, send the follower information
            // same thing as cell.usernameLabel.text = follower.login ( but we did this in func set() within FollowersCell.swift file
            return cell
        })
    }
    
    
    func updateData(on followers: [Follower]){
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        
        // UI stuff needs to be on the main thread
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
    }
}


extension followerListVC: UICollectionViewDelegate{ // conform to delegate
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y   // how far youve scrolled down
        let contentHeight = scrollView.contentSize.height  // 100 followers content height
        let heightOfScrollView = scrollView.frame.size.height // height of iphone screen
        
        //        print("offsetY: \(offsetY)")
        //        print("contentHeight: \(contentHeight)")
        //        print("heightOfScrollView: \(heightOfScrollView)")
        // trigger get new followers if :
        
        if offsetY > contentHeight - heightOfScrollView{
            
            // Only increment by 1 more page if hasMoreFollowers. else do nothing and return
            guard hasMoreFollowrs else {
                return
            }
            
            pageCounter += 1
            getFollowers(username: username, page: pageCounter)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activeArray = isSearching ? filteredFollowers : followers
        let eachFollower = activeArray[indexPath.item]
        let destVC = UserInfoVC()
        destVC.username = eachFollower.login
        destVC.delegate = self // followerListVC is listening to userInfoVC. 
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}


// when search result in search bar changes.
extension followerListVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        // make sure filter (text) is not empty
        guard let filter = searchController.searchBar.text, !filter.isEmpty else{ return}
        isSearching = true
        filteredFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased()) }
        //update collection view data
        updateData(on: filteredFollowers)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}

extension followerListVC: followerListVCDeligate{
    func didRequestFollowers(for username: String) {
        //1. reset everything
        self.username = username
        title = username
        pageCounter = 1
        followers.removeAll() // empty out followers
        filteredFollowers.removeAll()
        updateData(on: followers)
        //        collectionView.setContentOffset(.zero, animated: true) // scroll up to the top
        
        //2. make network call to get followers for that user, then reser the screen
        getFollowers(username: username, page: pageCounter)
        // rerun list of followers
    }
}


