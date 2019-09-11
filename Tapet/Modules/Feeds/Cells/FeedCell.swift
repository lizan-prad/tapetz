//
//  FeedCell.swift
//  Tapet
//
//  Created by Lizan P on 9/10/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit
import SDWebImage

class FeedCell: UITableViewCell, RealmPersistenceType {

    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var model: PictureModel? {
        didSet {
            if UIViewController().getAllIds().contains(model?.id ?? "") {
                self.likeBtn.setImage(UIImage.init(named: "heart"), for: .normal)
            } else {
                self.likeBtn.setImage(UIImage.init(named: "fav"), for: .normal)
            }
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
            
            likeBtn.addTarget(self, action: #selector(like), for: .touchUpInside)
        }
    }
    
    @objc func like() {
        if UIViewController().getAllIds().contains(model?.id ?? "") {
            let models : [PictureRealmModel] = self.fetch()
            let thisModel = models.filter{$0.id == model?.id ?? ""}
            self.delete(models: thisModel)
            likes.text = "\((self.model?.likes ?? 0) - 1)"
            self.likeBtn.setImage(UIImage.init(named: "fav"), for: .normal)
            return
        }
        self.model?.imageData = self.userImage.image?.sd_imageData()
        if let model = model?.toRealm() {
            self.save(models: [model])
             likes.text = "\((self.model?.likes ?? 0) + 1)"
            likeBtn.setImage(UIImage.init(named: "heart"), for: .normal)
        }
    }
}
