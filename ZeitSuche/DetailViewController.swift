//
//  DetailViewController.swift
//  ZeitSuche
//
//  Created by Bodo Schönfeld on 23/06/16.
//  Copyright © 2016 Bodo Schönfeld. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // IB outlets
    @IBOutlet weak var supertitle: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var articleButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    
    // Properties
    var searchResult: SearchResult!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.tintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 1)
        popupView.layer.cornerRadius = 10
        
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(DetailViewController.close))
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
        
        if searchResult != nil {
            updateUI()
        }
        
    }

    func updateUI() {
        
        supertitle.text = searchResult.supertitle
        titleLabel.text = searchResult.title
        subtitleLabel.text = searchResult.teaserText
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowArticle" {
            
            let articleViewController = segue.destination
                as! ArticleViewController
            
            articleViewController.searchResult = searchResult
        }
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }

}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
                                 source: UIViewController)
        -> UIPresentationController? {
            return DimmingPresentationController(
                presentedViewController: presented,
                presenting: presenting)
    }
    
}

extension DetailViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
    
}

