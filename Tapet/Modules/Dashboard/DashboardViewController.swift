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


class DashboardViewController: CustomTransitionViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var wallpapers: [PictureModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        let imgView = UIImageView.init(image: UIImage.init(named: "4960330-256"))
        imgView.contentMode = .scaleAspectFit
        imgView.frame.size.height = 40
        self.navigationItem.titleView = imgView
        fetchWallpapers()
    }
    
    func fetchWallpapers() {
       
        self.startAnimating(type: .ballGridPulse)
        Auth.shared.requestArray(BasePictureModel<PictureModel>.self, urlExt: "?client_id=\(Constants.clientId)&page=1&per_page=100", method: .get, param: nil, encoding: URLEncoding.default, headers: nil, completion: { (model) in
            self.stopAnimating()
            self.wallpapers = model.data
        }) { (error) in
            self.stopAnimating()
     
        }
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
}
