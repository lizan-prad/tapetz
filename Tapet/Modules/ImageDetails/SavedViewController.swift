//
//  SavedViewController.swift
//  Tapet
//
//  Created by Lizan P on 8/28/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    

}
