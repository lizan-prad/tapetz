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
import collection_view_layouts
import Persei
import FBSDKCoreKit
import FBSDKMarketingKit

class DashboardViewController: CustomTransitionViewController, LayoutDelegate {
    
    func cellSize(indexPath: IndexPath) -> CGSize {
        return cellsSizes[indexPath.row]
    }
    
    private var cellsSizes = [CGSize]()

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let categories: [(String,UIImage?)] = [("All",UIImage.init(named: "lo")), ("Animals",UIImage.init(named: "animal")), ("Cute",UIImage.init(named: "cute")), ("Girls",UIImage.init(named: "Girls")), ("Nature",UIImage.init(named: "nature")), ("City",UIImage.init(named: "City")), ("Fashion",UIImage.init(named: "fashion")), ("Underwater",UIImage.init(named: "underwater"))]
    
    var items: [MenuItem]? {
        return categories.map {
            MenuItem(title: $0.0,image: $0.1 ?? UIImage())
        }
    }
    
    var wallpapers: [PictureModel]? {
        didSet {
            let range = 50...150
            cellsSizes.removeAll()
            self.cellsSizes = wallpapers?.map({ (_) -> CGSize in
                let height = CGFloat(Int.random(in: range))
                return CGSize(width: 0.1, height: height)
            }) ?? []
            self.setupLayoput()
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
         self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "fav"), style: .plain, target: self, action: #selector(favTapped))
        searchField.round()
        searchField.addTarget(self, action: #selector(didChangeText(sender:)), for: .editingChanged)
        searchField.attributedPlaceholder = NSAttributedString.init(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        setupMenu()
        
        fetchWallpapers()
   
    }
    
    func logSearchEvent(contentType : String, contentData : String, contentId : String, searchString : String, success : Bool) {
        let params : [String : Any] = [
            "ContentType" : contentType,
            "Content" : contentData,
            "SearchString" : searchString,
            "Success" :  success
        ]
       AppEvents.logEvent(AppEvents.Name.searched, parameters: params)
    }
    
    @objc func favTapped() {
        let vc = UIStoryboard.init(name: "Favourites", bundle: nil).instantiateViewController(withIdentifier: "FavouritesViewController") as! FavouritesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupMenu() {
        let menu = MenuView()
        menu.items = self.items ?? []
        menu.delegate = self
        menu.backgroundColor = UIColor.init(hex: "#252627")
        collectionView.addSubview(menu)
    }
    
    func setupLayoput() {
        let layout: BaseLayout = FlickrLayout()
        layout.delegate = self
        layout.contentPadding = ItemsPadding(horizontal: 10, vertical: 10)
        layout.cellsPadding = ItemsPadding(horizontal: 8, vertical: 8)
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
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
            if !view.isHidden {
                self.searchField.becomeFirstResponder()
            } else {
                self.searchField.resignFirstResponder()
            }
        })
    }
    
    func searchWallpapers(text: String) {
         self.searchField.resignFirstResponder()
        self.startAnimating(type: .ballGridPulse)
        Auth.shared.request(SearchBaseModel.self, urlExt: "search/photos?client_id=\(Constants.clientId)&page=1&per_page=100&query=\(text)", method: .get, param: nil, encoding: URLEncoding.default, headers: nil, completion: { (model) in
            self.logSearchEvent(contentType: text, contentData: model.result?.first?.alt_description ?? "", contentId: model.result?.first?.id ?? "", searchString: text, success: true)
            self.stopAnimating()
            self.wallpapers = model.result
        }) { (error) in
            self.logSearchEvent(contentType: text, contentData: "", contentId: "", searchString: text, success: false)
            self.stopAnimating()
            
        }
    }
    
    func fetchWallpapers() {
       
        self.startAnimating(type: .ballGridPulse)
        Auth.shared.requestArray(BasePictureModel<PictureModel>.self, urlExt: "photos?client_id=\(Constants.clientId)&page=1&per_page=150", method: .get, param: nil, encoding: URLEncoding.default, headers: nil, completion: { (model) in
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

extension DashboardViewController: MenuViewDelegate {
    
    func menu(_ menu: MenuView, didSelectItemAt index: Int) {
      // alter mode of dataSource
        if index == 0 {
            self.fetchWallpapers()
            return
        }
        self.searchWallpapers(text: self.categories[index].0)
        
    }
}

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            return CGSize.init(width: self.view.frame.width/3 - 15, height: 280)
//        }
//        return CGSize.init(width: self.view.frame.width/2 - 15, height: 280)
//    }
    
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
