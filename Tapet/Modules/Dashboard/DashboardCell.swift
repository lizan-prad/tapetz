//
//  DashboardCell.swift
//  Tapet
//
//  Created by Lizan P on 8/28/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit
import SDWebImage

class DashboardCell: UICollectionViewCell, RealmPersistenceType {
    
    @IBOutlet weak var favView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likesBackView: UIView!
    
    var model: PictureModel? {
        didSet {
            likesBackView.layer.cornerRadius = likesBackView.frame.height/2
            likesLabel.text = "\(model?.likes ?? 0)"
            imageView.layer.cornerRadius = 8
            activityIndicator.startAnimating()
            imageView.sd_setImage(with: URL.init(string: model?.urls?.small ?? ""), placeholderImage: nil, options: .refreshCached) { (_, _, _, _) in
                self.activityIndicator.stopAnimating()
            }
            if UIViewController().getAllIds().contains(model?.id ?? "") {
                self.favView.image = UIImage.init(named: "heart")
            } else {
                self.favView.image = UIImage.init(named: "fav")
            }
            likesBackView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(likeAction)))
        }
    }
    
    @objc func likeAction() {
        if UIViewController().getAllIds().contains(model?.id ?? "") {
            let models : [PictureRealmModel] = self.fetch()
            let thisModel = models.filter{$0.id == model?.id ?? ""}
            self.delete(models: thisModel)
            likesLabel.text = "\((model?.likes ?? 0) - 1)"
            self.favView.image = UIImage.init(named: "fav")
            return
        }
        self.model?.imageData = self.imageView.image?.sd_imageData()
        if let model = model?.toRealm() {
        self.save(models: [model])
            likesLabel.text = "\((self.model?.likes ?? 0) + 1)"
            favView.image = UIImage.init(named: "heart")
        }
    }
}
