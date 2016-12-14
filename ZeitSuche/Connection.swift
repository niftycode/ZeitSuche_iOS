//
//  Connection.swift
//  ZeitSuche
//
//  Created by Bodo Schönfeld on 23/06/16.
//  Copyright © 2016 Bodo Schönfeld. All rights reserved.
//

import Foundation

class Connection {
    
    static func GETSession(_ urlString: String, completion:@escaping (_ error: NSError?, _ data: Data?) -> Void) {
        
        struct APIKey {
            static let myDeveloperKey = "--> enter your API key here <--"
        }
        
        let url = URL(string: urlString)
        let authString = APIKey.myDeveloperKey
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue(authString, forHTTPHeaderField: "X-Authorization")
        
        self.serverCommunication(request: request, completion: completion)
        
    }
    
    static func serverCommunication(request: URLRequest,
                                    completion:@escaping (_ error: NSError?, _ data: Data?) -> Void) {
        
        // ############### Configuration for NSURLSession ###############
        
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: request, completionHandler: { (data, _, error) in
            
            guard let data = data else {
                // Value requirements  n o t  met, do something
                print(error!.localizedDescription); return
            }
            
            // Do stuff with data...
            completion(nil, data)
        })
        task.resume()
        
    }
}


