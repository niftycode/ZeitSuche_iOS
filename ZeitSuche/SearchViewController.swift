//
//  ViewController.swift
//  ZeitSuche
//
//  Created by Bodo Schönfeld on 10/06/16.
//  Copyright © 2016 Bodo Schönfeld. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - IB outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var searchResults = [SearchResult]()
    var hasSearched = false
    var isLoading = false
    
    // symbolic constants
    struct TableViewCellIdentifiers {
        static let searchResultCell = "SearchResultCell"
        static let nothingFoundCell = "NothingFoundCell"
        static let loadingCell = "LoadingCell"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.becomeFirstResponder()
        
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        tableView.rowHeight = 80
        
        // register the cell NIBs
        var cellNib = UINib(nibName: TableViewCellIdentifiers.searchResultCell, bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.searchResultCell)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.registerNib(cellNib,
                              forCellReuseIdentifier: TableViewCellIdentifiers.nothingFoundCell)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.loadingCell, bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier:
            TableViewCellIdentifiers.loadingCell)
    }
    
    // create an alert
    func showNetworkError() {
        let alert = UIAlertController(
            title: "Hinweis",
            message:
            "Bei der Suche ist ein Fehler aufgetreten. Bitte versuchen Sie es noch einmal.",
            preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // create the search string
    func urlWithSearchText(searchText: String) -> String {
        
        let escapedSearchText =
            searchText.stringByAddingPercentEncodingWithAllowedCharacters(
                NSCharacterSet.URLQueryAllowedCharacterSet())
        
        let urlString = String(format: "http://api.zeit.de/content?q=title:%@&limit=20", escapedSearchText!)
        
        // print("URL: \(urlString)")
        
        return urlString
        
    }
    
    // parse JSON data
    func parseJSON(data: NSData) -> [String: AnyObject]? {
        
        do {
            return try NSJSONSerialization.JSONObjectWithData(
                data, options: []) as? [String: AnyObject]
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
        
    }
    
    // parse dictionary
    func parseDictionary(dictionary: [String: AnyObject]) -> [SearchResult] {
        
        guard let array = dictionary["matches"] as? [AnyObject] else {
            print("Expected 'matches' array")
            return []
        }
        
        var searchResults = [SearchResult]()
        
        for resultDict in array {
            
            if let resultDict = resultDict as? [String: AnyObject] {
                
                var searchResult: SearchResult?
                
                searchResult = parseResults(resultDict)
                
                if let result = searchResult {
                    searchResults.append(result)
                } else {
                    print("error parsing the dictionary")
                }
            }
        }
        // print(array)
        return searchResults
    }
    
    // parse dictionary content
    func parseResults(dictionary: [String: AnyObject]) -> SearchResult {
    
        let searchResult = SearchResult()
        
        if let st = dictionary["supertitle"] {
            searchResult.supertitle = st as! String
        }
        
        searchResult.title = dictionary["title"] as! String
        
        if let t = dictionary["teaser_text"] {
            searchResult.teaserText = t as! String
        }
        
        searchResult.articleURL = dictionary["href"] as! String
        
        let tempDate: String = dictionary["release_date"] as! String
        searchResult.date = ArticleDate.parseDate(tempDate)
        
        return searchResult
    }
}

// MARK: - Extensions
// UISearchBar delegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        if !searchBar.text!.isEmpty {
            
            searchBar.resignFirstResponder()
            
            isLoading = true
            tableView.reloadData()
            
            hasSearched = true
            searchResults = [SearchResult]()
            
            let searchString = urlWithSearchText(searchBar.text!)
            
            Connection.GETSession(searchString) { (error, data) in
                
                if let data = data, dictionary = self.parseJSON(data) {
                    self.searchResults = self.parseDictionary(dictionary)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.isLoading = false
                        self.tableView.reloadData()
                    }
                    return
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.hasSearched = false
                    self.isLoading = false
                    self.tableView.reloadData()
                    self.showNetworkError()
                }
            }
        }
    }
    
    // unify the status bar with the search bar
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
    
}

// We have to make SearchViewController to conform to these protocols,
// because of not using an UITableViewController.
extension SearchViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isLoading {
            return 1
        } else if !hasSearched {
            return 0
        } else if searchResults.count == 0 {
            return 1
        } else {
            return searchResults.count
        }
        
    }
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if isLoading {
            let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellIdentifiers.loadingCell, forIndexPath:indexPath)
            
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
        } else if searchResults.count == 0 {
            return tableView.dequeueReusableCellWithIdentifier(
                TableViewCellIdentifiers.nothingFoundCell,
                forIndexPath: indexPath)
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(
                TableViewCellIdentifiers.searchResultCell,
                forIndexPath: indexPath) as! SearchResultCell
            let searchResult = searchResults[indexPath.row]
            cell.titleLabel.text = searchResult.title
            cell.dateLabel.text = searchResult.date
            
            return cell
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowDetail" {
            
            let detailViewController = segue.destinationViewController
                as! DetailViewController
            
            let indexPath = sender as! NSIndexPath
            let searchResult = searchResults[indexPath.row]
            
            detailViewController.searchResult = searchResult
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("ShowDetail", sender: indexPath)
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if searchResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
}
