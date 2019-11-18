//
//  AppDelegate.swift
//  Tapet
//
//  Created by Hem Raj Bhatt on 8/27/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit
import GoogleMobileAds
import FBSDKCoreKit
import Firebase

let appdelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let nav = UINavigationBar.appearance()
        
        // GOOGLE ADS SETUP
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        UIApplication.shared.statusBarStyle = .lightContent
        ////
        FirebaseApp.configure()
        nav.barTintColor = UIColor.init(hex: "#252627")
        nav.tintColor = Constants.baseColor
        nav.isTranslucent = false
        nav.shadowImage = UIImage()
        nav.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        if UserDefaults.standard.value(forKey: "ID") == nil {
            UIView.transition(with: window ?? UIWindow(), duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
            }, completion: { completed in
                // maybe do something here
            })
        } else {
//            UIView.transition(with: window ?? UIWindow(), duration: 0.4, options: .showHideTransitionViews, animations: {
              self.window?.rootViewController =  self.loadHome()
//            }, completion: { completed in
//                // maybe do something here
//            })
        }
        
        // Override point for customization after application launch.
        return true
    }
    
   
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = ApplicationDelegate.shared.application(app, open: url, options: options)
        
        // Add any custom logic here.
        
        return handled
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func loadHome() -> UITabBarController{
        let feedVc =  UIStoryboard.init(name: "Feeds", bundle: nil).instantiateViewController(withIdentifier: "FeedsViewController") as! FeedsViewController
        let tabItem1                               = UITabBarItem()
        
        tabItem1.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white] , for: .normal)
        
        tabItem1.image                                                    = UIImage(named:"1515183-64")
        tabItem1.title                                                    = "Feeds"
        tabItem1.selectedImage = UIImage(named:"1515183-64")
        feedVc.tabBarItem                                  = tabItem1
        
        
        let dashboardVc =  UIStoryboard.init(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        let tabItem2                               = UITabBarItem()
        
        tabItem2.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray] , for: .normal)
        
        tabItem2.image                                                    = UIImage(named:"352300-64")
        tabItem2.title                                                    = "Wallpapers"
        tabItem2.selectedImage = UIImage(named:"352300-64")
        dashboardVc.tabBarItem                                  = tabItem2
        
        let favoriteVc =  UIStoryboard.init(name: "Favourites", bundle: nil).instantiateViewController(withIdentifier: "FavouritesViewController") as! FavouritesViewController
        let tabItem3                               = UITabBarItem()
        
        tabItem3.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray] , for: .normal)
        
        tabItem3.image                                                    = UIImage(named:"fav")
        tabItem3.title                                                    = "Favorites"
        tabItem3.selectedImage = UIImage(named:"fav")
        favoriteVc.tabBarItem                                  = tabItem3
        
        let tbcontroller = UITabBarController()
        
        tbcontroller.viewControllers = [UINavigationController.init(rootViewController: feedVc), UINavigationController.init(rootViewController: dashboardVc),UINavigationController.init(rootViewController: favoriteVc)]
        
        tbcontroller.tabBar.barTintColor = UIColor.init(hex: "#181A1A")
        tbcontroller.tabBar.tintColor = Constants.baseColor
        return tbcontroller
    }
    
}

extension UIViewController {
    
}
