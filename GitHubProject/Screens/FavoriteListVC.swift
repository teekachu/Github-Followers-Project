//
//  FavoriteListVC.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/14/20.
//

import UIKit

class FavoriteListVC: UIViewController {
    
    let tableView = UITableView()
    var favorites:[Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds  // how big to be
        tableView.rowHeight = 80
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func getFavorites(){
        PersistanceManager.retreveFavorites {[weak self] (result) in
            guard let self = self else{return}
            switch result{
            case .success(let favorites):
                if favorites.isEmpty{
                    self.showEmptyStateView(with: "UH Oh, there are no favorites😔 Add one on the follower screen", in: self.view)
                } else{
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)  // make sure tableview is up and showing
                    }
                }
            case .failure(let error):
                self.presentGFalertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Okay..")
            }
        }
    }
}


extension FavoriteListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorites: favorite) // where we set the username and download image
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC()
        destVC.username = favorite.login
        destVC.title = favorite.login
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    // editing style to swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else{return}
        
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.updateWith(favorite: favorite, actionType: .remove) {[weak self] (error) in
            guard let self = self else{return}
            guard let error = error else{return} // no error
            self.presentGFalertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Dang")
            
        }
    }
}
