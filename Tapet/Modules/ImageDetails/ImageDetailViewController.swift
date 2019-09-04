//
//  ImageDetailViewController.swift
//  Tapet
//
//  Created by Lizan P on 8/28/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit
import Hero
import SDWebImage
import GoogleMobileAds
import Alamofire

class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var wallpaperImage: UIImageView!
    var picture: PictureModel?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        admobDelegate.showAd()
        wallpaperImage.hero.id = picture?.id
        self.hero.isEnabled = true
        self.navigationController?.navigationBar.isHidden = true
    
         self.startAnimating(type: .ballGridPulse)
        wallpaperImage.sd_setImage(with: URL.init(string: picture?.urls?.full ?? ""), placeholderImage: image, options: .refreshCached) { (image, error, _, url) in
            
             self.stopAnimating()
            if self.getAllIds().contains(self.picture?.id ?? "" ) {
            self.picture?.imageData = image?.sd_imageData()
            if let model = self.picture?.toRealm() {
                self.save(models: [model])
            }
            }
        }
        
         wallpaperImage.isUserInteractionEnabled = true
        let swipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(handleGesture(gesture:)))
        swipeGesture.direction = .down
        self.wallpaperImage.addGestureRecognizer(swipeGesture)
        self.wallpaperImage.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleTap)))
        self.handleTap()
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
    
    @objc func handleTap() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageDataViewController") as! ImageDataViewController
        vc.model = self.picture
        vc.image = self.image
        vc.didTapDownload = {
            self.savePhoto()
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func savePhoto() {
        UIImageWriteToSavedPhotosAlbum(self.wallpaperImage.image ?? UIImage(), self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SavedViewController") as! SavedViewController
            vc.didDismiss = {
                currentVc = self
                if (admobDelegate.interstitialView.isReady == true){
                    admobDelegate.interstitialView.present(fromRootViewController:currentVc)
                }
            }
            self.present(vc, animated: true, completion: nil)
            
        }
    }
}

extension UIView {
    
    func round() {
        self.layer.cornerRadius = self.frame.height/2
    }
}
extension UIViewController: RealmPersistenceType {
    
    func getAllIds() -> [String] {
        let datas: [PictureRealmModel] = self.fetch()
        return datas.map{$0.id}
    }
}
