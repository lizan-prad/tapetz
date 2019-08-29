//
//  DashboardCell.swift
//  Tapet
//
//  Created by Lizan P on 8/28/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit
import SDWebImage

class DashboardCell: UICollectionViewCell {
    
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
            imageView.sd_setImage(with: URL.init(string: model?.urls?.regular ?? ""), placeholderImage: nil, options: .refreshCached) { (_, _, _, _) in
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
