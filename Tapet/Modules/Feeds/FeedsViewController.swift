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
    
    var wallpapers: [PictureModel]? {
        didSet {
            wallpapers = self.wallpapers?.sorted(by: { (a, b) -> Bool in
                return a.imageDate ?? Date() > b.imageDate ?? Date()
            })
            self.tableView.reloadData()
        }
    }
    
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
    
    func getImages() {
        self.startAnimating(type: .ballGridPulse)
        Auth.shared.requestArray(BasePictureModel<PictureModel>.self, urlExt: "photos?client_id=\(Constants.clientId)&page=1&per_page=150", method: .get, param: nil, encoding: URLEncoding.default, headers: nil, completion: { (model) in
            self.stopAnimating()
            self.wallpapers = model.data
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
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
