//
//  NVIndicator.swift
//  Tapet
//
//  Created by Lizan P on 8/28/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable {
    
    func startAnimating(type: NVActivityIndicatorType) {
         startAnimating(CGSize.init(width: 40, height: 40), message: nil, messageFont: nil, type: type, color: Constants.baseColor, padding: 5, displayTimeThreshold: 10, minimumDisplayTime: 1, backgroundColor: .clear, textColor: nil, fadeInAnimation: nil)
    }
    
    func stopAnimating() {
        self.stopAnimating(nil)
    }
}
