//
//  FeedsViewController.swift
//  Tapet
//
//  Created by Lizan P on 9/10/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import UIKit
import Alamofire

class FeedsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var ind = 1
    var wallpapers: [PictureModel]?
    
    var trendingUser: [PictureModel]? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgView = UIImageView.init(image: UIImage.init(named: "logo"))
        imgView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imgView
        tableView.dataSource = self
        tableView.delegate = self
        getImages()
    }
    
    func reloadData() {
        wallpapers = self.wallpapers?.sorted(by: { (a, b) -> Bool in
            return a.imageDate ?? Date() > b.imageDate ?? Date()
        })
        self.tableView.reloadData()
    }
    
    func getImages() {
        ind = 1
        self.startAnimating(type: .ballGridPulse)
        Auth.shared.requestArray(BasePictureModel<PictureModel>.self, urlExt: "photos?client_id=\(Constants.clientId)&page=1&per_page=100", method: .get, param: nil, encoding: URLEncoding.default, headers: nil, completion: { (model) in
            self.stopAnimating()
            self.wallpapers = model.data
            self.reloadData()
        }) { (error) in
            self.stopAnimating()
            
        }
    }
    
    func paginate(index: Int) {
        self.startAnimating(type: .ballGridPulse)
        Auth.shared.requestArray(BasePictureModel<PictureModel>.self, urlExt: "photos?client_id=\(Constants.clientId)&page=\(index)&per_page=100", method: .get, param: nil, encoding: URLEncoding.default, headers: nil, completion: { (model) in
            self.stopAnimating()
            var walla = self.wallpapers ?? []
            model.data?.forEach{walla.append($0)}
            self.wallpapers = walla.sorted(by: { (a, b) -> Bool in
                return a.imageDate ?? Date() > b.imageDate ?? Date()
            })
            self.tableView.reloadData()
        }) { (error) in
            self.stopAnimating()
            
        }
    }

}

extension FeedsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallpapers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
        cell.model = self.wallpapers?[indexPath.row]
        if indexPath.row == (wallpapers?.count ?? 0) - 1 {
            ind = ind + 1
            self.paginate(index: ind )
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 390
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FeedCell
        cell.userImage.hero.id = cell.model?.id
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FeedsDetailsViewController") as! FeedsDetailsViewController
        vc.model = wallpapers?[indexPath.row]
        vc.image = cell.userImage.image
        self.present(vc, animated: true, completion: nil)
    }
}
