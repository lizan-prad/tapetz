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

    @IBOutlet weak var infoVIew: UIView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var favBtn: UIButton!
    
    var image: UIImage?
    var model: PictureModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         admobDelegate.showAd()
        infoVIew.layer.cornerRadius = 5
        feedImage.hero.id = model?.id
        self.hero.isEnabled = true
        feedImage.sd_setImage(with: URL.init(string: model?.urls?.full ?? "") , placeholderImage: image, options: .refreshCached) { (_, _, _, _) in
            
        }
        
        if UIViewController().getAllIds().contains(model?.id ?? "") {
            self.favBtn.setImage(UIImage.init(named: "heart"), for: .normal)
        } else {
            self.favBtn.setImage(UIImage.init(named: "fav"), for: .normal)
        }
        view.isUserInteractionEnabled = true
        let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(cancel))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
        self.info.text = "#Unsplash \n" + (model?.descriptions ?? model?.alt_description ?? "")
        self.desc.text = model?.alt_description
//        getImages()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getImages() {
        Auth.shared.requestArray(PictureModel.self, urlExt: "photos/\(model?.id ?? "")", method: .get, param: nil, encoding: URLEncoding.default, headers: nil, completion: { (model) in

            
        }) { (error) in
            
        }
    }
    
    func savePhoto() {
        self.startAnimating(type: .ballGridPulse)
        UIImageWriteToSavedPhotosAlbum(self.feedImage.image ?? UIImage(), self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        self.stopAnimating()
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let vc = UIStoryboard.init(name: "ImageDetails", bundle: nil).instantiateViewController(withIdentifier: "SavedViewController") as! SavedViewController
            vc.didDismiss = {
                currentVc = self
                if (admobDelegate.interstitialView.isReady == true){
                    admobDelegate.interstitialView.present(fromRootViewController:currentVc)
                }
            }
            self.present(vc, animated: true, completion: nil)
            
        }
    }

    @IBAction func favAction(_ sender: Any) {
        if UIViewController().getAllIds().contains(model?.id ?? "") {
            let models : [PictureRealmModel] = self.fetch()
            let thisModel = models.filter{$0.id == model?.id ?? ""}
            self.delete(models: thisModel)
            self.favBtn.setImage(UIImage.init(named: "fav"), for: .normal)
            return
        }
        self.model?.imageData = self.feedImage.image?.sd_imageData()
        if let model = model?.toRealm() {
            self.save(models: [model])
            
            favBtn.setImage(UIImage.init(named: "heart"), for: .normal)
        }
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        savePhoto()
    }
    
    @IBAction func sendAction(_ sender: Any) {
        let imageShare = [ self.feedImage.image! ]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
