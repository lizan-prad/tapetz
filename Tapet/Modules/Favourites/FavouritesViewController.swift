//
//  FavouritesViewController.swift
//  Tapet
//
//  Created by Lizan P on 8/30/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit
import collection_view_layouts

class FavouritesViewController: UIViewController, LayoutDelegate {
    
    func cellSize(indexPath: IndexPath) -> CGSize {
        return cellsSizes[indexPath.row]
    }
    
    private var cellsSizes = [CGSize]()
    
    @IBOutlet weak var collectionView: UICollectionView!
   
    var wallapapers = [PictureRealmModel]() {
        didSet {
            let range = 50...150
            cellsSizes.removeAll()
            self.cellsSizes = wallapapers.map({ (_) -> CGSize in
                let height = CGFloat(Int.random(in: range))
                return CGSize(width: 0.1, height: height)
            })
            self.setupLayoput()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        let imgView = UIImageView.init(image: UIImage.init(named: "logo"))
        imgView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imgView
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchPictures()
    }
    
    func fetchPictures() {
        wallapapers = self.fetch()
    }
    
    func setupLayoput() {
        let layout: BaseLayout = FacebookLayout()
        layout.delegate = self
        layout.contentPadding = ItemsPadding(horizontal: 10, vertical: 10)
        layout.cellsPadding = ItemsPadding(horizontal: 8, vertical: 8)
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavouritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallapapers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouritesCell", for: indexPath) as! FavouritesCell
        cell.realmModel = wallapapers[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FavouritesCell
        cell.imageView.hero.id = cell.realmModel?.id
        let vc = UIStoryboard.init(name: "Favourites", bundle: nil).instantiateViewController(withIdentifier: "FavouriteImageViewController") as! FavouriteImageViewController
        vc.image = cell.realmModel?.image
        vc.id = cell.realmModel?.id
        let nav = UINavigationController.init(rootViewController: vc)
        nav.hero.isEnabled = true
        self.present(nav, animated: true, completion: nil)
    }
}
