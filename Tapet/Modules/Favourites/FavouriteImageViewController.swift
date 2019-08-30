//
//  FavouriteImageViewController.swift
//  Tapet
//
//  Created by Lizan P on 8/30/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit

class FavouriteImageViewController: UIViewController {

    var image: Data?
    var id: String?
    @IBOutlet weak var wallpaperImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        admobDelegate.showAd()
        wallpaperImage.hero.id = id
        self.hero.isEnabled = true
        self.navigationController?.navigationBar.isHidden = true
        wallpaperImage.image = UIImage.init(data: image ?? Data())
        wallpaperImage.isUserInteractionEnabled = true
        let swipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(handleGesture(gesture:)))
        swipeGesture.direction = .down
        self.wallpaperImage.addGestureRecognizer(swipeGesture)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismissView()
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .down {
            self.dismissView()
        }
}
}
