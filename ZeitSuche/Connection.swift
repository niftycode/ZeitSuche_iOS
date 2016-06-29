//
//  Connection.swift
//  ZeitSuche
//
//  Created by Bodo Schönfeld on 23/06/16.
//  Copyright © 2016 Bodo Schönfeld. All rights reserved.
//

import Foundation

class Connection {
    
    static func GETSession(urlString: String, completion:(error: NSError?, data: NSData?) -> Void) {
        
        struct APIKey {
            static let myDeveloperKey = "--> enter your API key here <--"
        }
        
        let url = NSURL(string: urlString)
        let authString = APIKey.myDeveloperKey
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue(authString, forHTTPHeaderField: "X-Authorization")
        
        self.serverCommunication(request: request, completion: completion)
        
    }
    
    static func serverCommunication(request request: NSMutableURLRequest, completion:(error: NSError?, data: NSData?) -> Void) {
        
        // ############### Configuration for NSURLSession ###############
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.allowsCellularAccess = true
        
        let session = NSURLSession(configuration: configuration)
        
        let task = session.dataTaskWithRequest(request) {
            (data, _, error) in
            guard let data = data else {
                // Value requirements  n o t  met, do something
                print(error); return
            }
            // Do stuff with data...
            completion(error: nil, data: data)
        }
        task.resume()
        
    }
}


