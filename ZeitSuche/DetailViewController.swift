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
        modalPresentationStyle = .Custom
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowArticle" {
            
            let articleViewController = segue.destinationViewController
                as! ArticleViewController
            
            articleViewController.searchResult = searchResult
        }
    }
    
    @IBAction func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    
    func presentationControllerForPresentedViewController(
        presented: UIViewController,
        presentingViewController presenting: UIViewController,
                                 sourceViewController source: UIViewController)
        -> UIPresentationController? {
            return DimmingPresentationController(
                presentedViewController: presented,
                presentingViewController: presenting)
    }
    
}

extension DetailViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
                           shouldReceiveTouch touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
    
}

