//
//  BaseViewController.swift
//  IMEPayWallet
//
//  Created by Manoj Karki on 10/8/17.
//  Copyright © 2017 imedigital. All rights reserved.
//

import UIKit
import CoreLocation

class BaseViewController: UIViewController {

    var viewDidAppearFirstTime: Bool = false
    var viewWillAppearFirstTime: Bool = false
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage.init(named: "back")
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
 
    }

    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if  !viewDidAppearFirstTime {
            viewDidAppearFirstTime = true
            viewDidAppearForFirstTime()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tbcontroller = self.tabBarController {
            guard let items = tbcontroller.tabBar.items else {
                return
            }
            let titles = ["Home","Deals","","Pay to","Profile"]
            for count in 0...items.count - 1 {
//                items[count].title = titles[count].localize
            }
        }
//        view.localize()
        if  !viewWillAppearFirstTime {
            viewWillAppearFirstTime = true
            viewWillAppearForFirstTime()
        }

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // stopReachabilityObserver()
    }

    func viewDidAppearForFirstTime() {}
    func viewWillAppearForFirstTime() {}

    func  requestForCurrentLocation() {
        //appDelegate.locationMangager.startUpdatingLoc()
    }

    func currentLocationUpdated(location: CLLocation?) {}


    
    @available(iOS 10.0, *)
    func triggerHapticFeedback(intensity: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
       
            let generator = UIImpactFeedbackGenerator(style: intensity)
            generator.impactOccurred()
        
    }

}



//MARK:- SideMenu Gesture Control





