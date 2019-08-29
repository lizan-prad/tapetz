//
//  ImageDataViewController.swift
//  Tapet
//
//  Created by Lizan P on 8/28/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit
import SDWebImage

class ImageDataViewController: UIViewController {

    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var userProfileView: UIImageView!
    @IBOutlet weak var imageDesc: UILabel!
    @IBOutlet weak var imageDimenssion: UILabel!
    @IBOutlet weak var imageColor: UILabel!
    @IBOutlet weak var sponsir: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var downloadView: UIView!
    
    var didTapDownload: (() -> ())?
    var didtapUserProfile:(() -> ())?
    var model: PictureModel?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(didTapView)))
        saveView.isUserInteractionEnabled = true
        saveView.layer.cornerRadius = saveView.frame.height/2
        bottomView.layer.cornerRadius = 5
        setup()
        downloadView.isUserInteractionEnabled = true
        downloadView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(downloadTap)))
        userProfileView.round()
        userProfileView.isUserInteractionEnabled = true
        userProfileView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(viewUserProfile)))
    }
    
    @objc func viewUserProfile() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
        vc.model = self.model
        vc.image = image
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func downloadTap() {
        self.dismiss(animated: true) {
            self.didTapDownload?()
        }
    }
    
    func setup() {
        likes.text = "\(model?.likes ?? 0)"
        userProfileView.sd_setImage(with: URL.init(string: model?.user?.profile_image?.medium ?? ""), placeholderImage: UIImage.init(named: "3336938-64"), options: .refreshCached) { (_, _, _, _) in
        }
        userName.text = model?.user?.name
        imageDimenssion.text = "\(model?.width ?? 0) x \(model?.height ?? 0)"
        imageDesc.text = model?.alt_description ?? model?.description
        imageColor.text = model?.color
        sponsir.text = "Sponsored by \(model?.sponsorship?.sponsor?.name ?? "")"
    }
    
    @objc func didTapView() {
        self.dismiss(animated: true, completion: nil)
    }

}
