//
//  AdsWebViewController.swift
//  IMEPayWallet
//
//  Created by Manoj Karki on 1/10/18.
//  Copyright © 2018 imedigital. All rights reserved.
//

import UIKit
import WebKit

//MARK:- View Controller to show ads when tapping offer items in home view

class AdsWebViewController: BaseWebViewController {

    var urlString: String?
    var viewTitle: String?



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let urlstring = urlString, let url = URL(string: urlstring)  {
           self.webView.load(URLRequest(url: url))
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = viewTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK:- Web View to show Terms and Conditions and Privacy Policy etc.

class AppInfoWebViewController : BaseWebViewController {

    var urlString: String?
    var viewTitle: String?

    @IBOutlet weak var shadowLine: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addDissmissBtn()
        // Do any additional setup after loading the view.
        if let urlstring = urlString, let url = URL(string: urlstring)  {
            self.webView.load(URLRequest(url: url))
        }
        
        onFinished = {
            self.view.bringSubviewToFront(self.shadowLine)
        }
    }

    func addDissmissBtn() {
        let cancelBtn = UIBarButtonItem(title: "Close", style: .plain, target: self, action:#selector(dissmissWebView))
        cancelBtn.tintColor = Constants.baseColor
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = cancelBtn
    }

    @objc func dissmissWebView() {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = viewTitle
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
