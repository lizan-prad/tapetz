//
//  DashboardViewController.swift
//  Tapet
//
//  Created by Lizan P on 8/28/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit
import Alamofire
import TransitionButton
import Hero

class DashboardViewController: CustomTransitionViewController {

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var wallpapers: [PictureModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchView.isHidden = true
        self.searchBtn.isHidden = searchField.text?.count == 0
        collectionView.dataSource = self
        collectionView.delegate = self
        let imgView = UIImageView.init(image: UIImage.init(named: "logo"))
        imgView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imgView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "search"), style: .plain, target: self, action: #selector(searchTapped))
        searchField.round()
        searchField.addTarget(self, action: #selector(didChangeText(sender:)), for: .editingChanged)
        searchField.attributedPlaceholder = NSAttributedString.init(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        fetchWallpapers()
    }
    
    @objc func didChangeText(sender: UITextField) {
        
            searchBtn.hideWithAnimation(hidden: sender.text?.count == 0)
        if sender.text?.count == 0 {
            self.fetchWallpapers()
        }
    }
    
    @objc func searchTapped() {
        setView(view: self.searchView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentVc = self
    }
    
    func setView(view: UIView) {
        UIView.transition(with: view, duration: 0.5, options: .showHideTransitionViews, animations: {
            view.isHidden = !view.isHidden
        })
    }
    
    func searchWallpapers(text: String) {
        self.startAnimating(type: .ballGridPulse)
        Auth.shared.request(SearchBaseModel.self, urlExt: "search/photos?client_id=\(Constants.clientId)&page=1&per_page=100&query=\(text)", method: .get, param: nil, encoding: URLEncoding.default, headers: nil, completion: { (model) in
            self.stopAnimating()
            self.wallpapers = model.result
        }) { (error) in
            self.stopAnimating()
            
        }
    }
    
    func fetchWallpapers() {
       
        self.startAnimating(type: .ballGridPulse)
        Auth.shared.requestArray(BasePictureModel<PictureModel>.self, urlExt: "photos?client_id=\(Constants.clientId)&page=1&per_page=100", method: .get, param: nil, encoding: URLEncoding.default, headers: nil, completion: { (model) in
            self.stopAnimating()
            self.wallpapers = model.data
        }) { (error) in
            self.stopAnimating()
     
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.searchWallpapers(text: self.searchField.text ?? "")
    }
}

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.view.frame.width/2 - 15, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallpapers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCell", for: indexPath) as! DashboardCell
        cell.model = wallpapers?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DashboardCell
        cell.imageView.hero.id = cell.model?.id
        let vc = UIStoryboard.init(name: "ImageDetails", bundle: nil).instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController
        vc.picture = cell.model
        vc.image = cell.imageView.image
        let nav = UINavigationController.init(rootViewController: vc)
        nav.hero.isEnabled = true
        self.present(nav, animated: true, completion: nil)
    }
}

extension UIView {
    func hideWithAnimation(hidden: Bool) {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.isHidden = hidden
        })
    }
}
