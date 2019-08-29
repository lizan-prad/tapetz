//
//  UserProfileViewController.swift
//  Tapet
//
//  Created by Lizan P on 8/29/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit
import SDWebImage

class UserProfileViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var wallpaperImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var collection: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var photos: UILabel!
    @IBOutlet weak var socialStack: UIStackView!
    @IBOutlet weak var detailStack: UIStackView!
    
    var model: PictureModel?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBlur()
        self.navigationController?.navigationBar.isHidden = true
        self.view.bringSubviewToFront(scrollView)
        self.view.bringSubviewToFront(backBtn)
       scrollView.delegate = self
        wallpaperImage.sd_setImage(with: URL.init(string: model?.urls?.full ?? ""), placeholderImage: image, options: .refreshCached) { (image, error, _, url) in
            
        }
        profileImage.round()
        animateBtn()
        self.setup()
        
        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        if currentOffset < 0.0 {
self.dismiss(animated: true, completion: nil)
        } else {
           
        }
    }
    
    func setup() {
        profileImage.sd_setImage(with: URL.init(string: model?.user?.profile_image?.medium ?? ""), placeholderImage: UIImage.init(named: "3336938-64"), options: .refreshCached) { (image, error, _, url) in
            
        }
        userName.text = model?.user?.name
        userBio.text = model?.user?.bio
        location.text = model?.user?.location
        collection.text = "\(model?.user?.total_collections ?? 0)"
        likes.text = "\(model?.user?.total_likes ?? 0)"
        photos.text = "\(model?.user?.total_photos ?? 0)"
    }
    
//    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
//        if gesture.direction == .down {
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
    
    func animateBtn() {
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            self.backBtn.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.3, animations: {
                                self.backBtn.transform = CGAffineTransform.identity
                            })
        })
    }
    
    func addBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        let swipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(handleGesture(gesture:)))
//        swipeGesture.direction = .down
//        blurEffectView.isUserInteractionEnabled = true
//        blurEffectView.addGestureRecognizer(swipeGesture)
        view.addSubview(blurEffectView)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func instaAction(_ sender: Any) {
        
        let instagramHooks = "instagram://user?username=\(self.model?.user?.instagram_username ?? "")"
        let instagramUrl = URL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl!) {
            UIApplication.shared.canOpenURL(instagramUrl!)
        } else {
            //redirect to safari because the user doesn't have Instagram
            guard let url = URL(string: "https://instagram.com/\(self.model?.user?.instagram_username ?? "")") else { return }
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func twitterAction(_ sender: Any) {
        let instagramHooks = "twitter://user?screen_name=\(self.model?.user?.instagram_username ?? "")"
        let instagramUrl = URL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl!) {
            UIApplication.shared.canOpenURL(instagramUrl!)
        } else {
        guard let url = URL(string: "https://twitter.com/\(self.model?.user?.twitter_username ?? "")") else { return }
        UIApplication.shared.open(url)
        }
    }
}
