//
//  FavouritesCell.swift
//  Tapet
//
//  Created by Lizan P on 8/30/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit

class FavouritesCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likesBackView: UIView!

    
    var realmModel: PictureRealmModel? {
        didSet {
            likesBackView.layer.cornerRadius = likesBackView.frame.height/2
            likesLabel.text = "\(realmModel?.likes ?? 0)"
            imageView.layer.cornerRadius = 8
            imageView.image = UIImage.init(data: realmModel?.image ?? Data())
        }
    }

}
