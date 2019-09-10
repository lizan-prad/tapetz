//
//  FeedCell.swift
//  Tapet
//
//  Created by Lizan P on 9/10/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit
import SDWebImage

class FeedCell: UITableViewCell {

    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var model: PictureModel? {
        didSet {
            self.userProfile.sd_setImage(with: URL.init(string: model?.user?.profile_image?.small ?? ""), placeholderImage: UIImage.init(named: "3336938-64"), options: .refreshCached) { (_, _, _, _) in
            }
            self.userProfile.round()
            self.userImage.layer.cornerRadius = 4
            userName.text = model?.user?.name
            address.text = model?.user?.location ?? "@\(model?.user?.username ?? "")"
           activity.startAnimating()
            userImage.sd_setImage(with: URL.init(string: model?.urls?.thumb ?? ""), placeholderImage: nil, options: .refreshCached) { (_, _, _, _) in
                self.userImage.sd_setImage(with: URL.init(string: self.model?.urls?.regular ?? ""), placeholderImage: nil, options: .refreshCached) { (_, _, _, _) in
                    self.activity.stopAnimating()
                }
            }
            likes.text = "\(model?.likes ?? 0)"
        }
    }
}
