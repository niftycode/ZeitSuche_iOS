//
//  ArticleViewController.swift
//  ZeitSuche
//
//  Created by Bodo Schönfeld on 25/06/16.
//  Copyright © 2016 Bodo Schönfeld. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController {
    
    // IB outlets
    @IBOutlet weak var webView: WKWebView!
    
    // Properties
    var searchResult: SearchResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let searchResult = searchResult {
            let articleURL = searchResult.articleURL
            let requestURL = URL(string:articleURL)
            let requestObject = URLRequest(url: requestURL!)
            webView.load(requestObject)
        } else {
            print("___ERROR___")
        }
    }
    
    @IBAction func closeArticleView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
