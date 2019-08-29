//
//  ViewController.swift
//  Tapet
//
//  Created by Hem Raj Bhatt on 8/27/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit
import Alamofire
import TransitionButton

class ViewController: UIViewController {

    @IBOutlet weak var enterBtn: TransitionButton!
    @IBOutlet weak var privacyBtn: UIButton!
    @IBOutlet weak var tearmsBtn: UIButton!
    @IBOutlet weak var checkBtn: UIButton!
    
    var agreed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
         enterBtn.isEnabled = agreed
        tearmsBtn.layer.borderColor = Constants.baseColor.cgColor
        tearmsBtn.layer.borderWidth = 3
        tearmsBtn.round()
        privacyBtn.round()
        // Do any additional setup after loading the view.
    }
    @IBAction func tearmsAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Ads", bundle: nil).instantiateViewController(withIdentifier: "AppInfoWebViewController") as! AppInfoWebViewController
        vc.urlString = "https://tapetz.flycricket.io/privacy.html"
        vc.viewTitle = "Tearms & Conditions"
        self.present(UINavigationController.init(rootViewController: vc), animated: true, completion: nil)
    }
    
    @IBAction func privacyAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Ads", bundle: nil).instantiateViewController(withIdentifier: "AppInfoWebViewController") as! AppInfoWebViewController
        vc.urlString = "https://tapetz.flycricket.io/privacy.html"
        vc.viewTitle = "Privacy Policy"
        self.present(UINavigationController.init(rootViewController: vc), animated: true, completion: nil)
    }
    
    @IBAction func termsAggrementAction(_ sender: Any) {
        agreed = !agreed
        enterBtn.isEnabled = agreed
        checkBtn.setImage(UIImage.init(named: agreed ? "check" : "uncheck"), for: .normal)
    }
    
    @IBAction func enterAction(_ sender: Any) {
        UserDefaults.standard.set("ACCEPTED", forKey: "ID")
        enterBtn.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                self.enterBtn.stopAnimation(animationStyle: .expand, completion: {
                    let secondVC = UIStoryboard.init(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
                    self.present(UINavigationController.init(rootViewController: secondVC) , animated: true, completion: nil)
                })
            })
        })
    }
    
}


//ACCESS KEY : - 22502590ac9a324c3c5cc2cebe61c13e6b7e6a18365377c38b2684f78ed8c358
//
//SECERET KEY : - a352b8ec84331110c4a57df9012ba0feab5837f6eb3457427fbbbc73046bdd0f
//
//urn:ietf:wg:oauth:2.0:oob

//https://unsplash.com/documentation#list-photos&page=2
//https://api.unsplash.com/photos/?client_id=22502590ac9a324c3c5cc2cebe61c13e6b7e6a18365377c38b2684f78ed8c358&page=1&per_page=100
