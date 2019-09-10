//
//  FeedsDetailsViewController.swift
//  Tapet
//
//  Created by Lizan P on 9/10/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class FeedsDetailsViewController: UIViewController {

    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var feedImage: UIImageView!
    
    var image: UIImage?
    var model: PictureModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedImage.hero.id = model?.id
        self.hero.isEnabled = true
        feedImage.sd_setImage(with: nil, placeholderImage: image, options: .refreshCached) { (_, _, _, _) in
            
        }
        getImages()
        // Do any additional setup after loading the view.
    }
    
    func getImages() {
        Auth.shared.requestArray(PictureModel.self, urlExt: "photos/\(model?.id ?? "")", method: .get, param: nil, encoding: URLEncoding.default, headers: nil, completion: { (model) in

            
        }) { (error) in
            
        }
    }

    @IBAction func favAction(_ sender: Any) {
        
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        
    }
    
    @IBAction func sendAction(_ sender: Any) {
        
    }
    
}
