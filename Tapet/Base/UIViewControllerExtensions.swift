//
//  UIViewControllerExtensions.swift
//  ChatApp
//
//  Created by mac on 3/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIView {
    
    func rounded() {
        self.layer.cornerRadius = self.frame.height/2
    }
}

struct Associate {
    static var hud: UInt8 = 0
    static var empty: UInt8 = 0
}

extension UIViewController{
    private func setProgressHud() -> MBProgressHUD {
        
        let progressHud:  MBProgressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHud.tintColor = UIColor.darkGray
        progressHud.removeFromSuperViewOnHide = true
        objc_setAssociatedObject(self, &Associate.hud, progressHud, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return progressHud
    }
    
    var progressHud: MBProgressHUD {
        if let progressHud = objc_getAssociatedObject(self, &Associate.hud) as? MBProgressHUD {
            progressHud.isUserInteractionEnabled = true
            return progressHud
        }
        return setProgressHud()
    }
    
    var progressHudIsShowing: Bool {
        return self.progressHud.isHidden
    }
    
    func showProgressHud() {
        self.progressHud.show(animated: false)
    }
    func showMessageHud(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
    }
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func hideProgressHud() {
        self.progressHud.label.text = ""
        self.progressHud.completionBlock = {
            objc_setAssociatedObject(self, &Associate.hud, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        self.progressHud.hide(animated: false)
    }
    
}
