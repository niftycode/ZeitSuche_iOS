//
//  ArticleViewController.swift
//  ZeitSuche
//
//  Created by Bodo Schönfeld on 25/06/16.
//  Copyright © 2016 Bodo Schönfeld. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    // IB outlets
    @IBOutlet weak var webView: UIWebView!
    
    // Properties
    var searchResult: SearchResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let searchResult = searchResult {
            let articleURL = searchResult.articleURL
            let requestURL = URL(string:articleURL)
            let requestObject = URLRequest(url: requestURL!)
            webView.loadRequest(requestObject)
        } else {
            print("___ERROR___")
        }
    }
    
    @IBAction func closeArticleView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
