//
//  FavSaveViewController.swift
//  Tapet
//
//  Created by Lizan P on 9/4/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit

class FavSaveViewController: UIViewController {

    @IBOutlet weak var saveView: UIView!
    
    var didTapDownload: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveView.isUserInteractionEnabled = true
        saveView.layer.cornerRadius = saveView.frame.height/2
        saveView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(downloadTap)))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissView)))
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func downloadTap() {
        self.dismiss(animated: true) {
            self.didTapDownload?()
        }
    }
}
