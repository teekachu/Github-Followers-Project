//
//  SceneDelegate.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/14/20.
//  Allows for multi-window operations. Same app can be displayed twice/Thrice in multiple scenes.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // configure scene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds) // fill up the screen
        window?.windowScene = windowScene
        
        //        exp: set the root VC to be the initial VC that came with project
        //        window?.rootViewController = ViewController()
        
        //Tab bar -> nav bar -> rootVC
        //        let tabBar = UITabBarController()
        //        window?.rootViewController = tabBar()
        window?.rootViewController = createTabBar()         // add icons to bottom of Tab bar
        window?.makeKeyAndVisible()
        
        //one tab bar, two tabs, each tab will have its own NavController, which will have its own array of VC.
        
        // MARK: REFACTOR OUT THESE TWO when added tab bar icons
        //        let searchNVC = UINavigationController(rootViewController: searchVC())
        //        let favoritesListNVC = UINavigationController(rootViewController: favoriteListVC())
        //        tabBar.viewControllers = [searchNVC, favoritesListNVC]
        
        configureNavigationBar()
    }
    
    // MARK: creating viewcontrollers and tab bar( with symbol in tab bar )
    
    func createSearchNavController() -> UINavigationController{
        
        let searchViewController = SearchVC()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchViewController)
    }
    
    func favoritesSearchNavController() -> UINavigationController{
        
        let favViewController = FavoriteListVC()
        favViewController.title = "Favorites"
        favViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favViewController)
    }
    
    func createTabBar() -> UITabBarController{
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        tabBar.viewControllers = [createSearchNavController(), favoritesSearchNavController()]
        return tabBar
    }
    
    func configureNavigationBar(){
        UINavigationBar.appearance().tintColor = .systemGreen
        // basically make the buttons all the way up top green and same as other colors.
    }
    
    
    //MARK: Empty func
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
    
    
}

