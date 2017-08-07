//
//  ReadData.swift
//  ZeitSuche
//
//  Created by Bodo Schönfeld on 16/07/16.
//  Copyright © 2016 Bodo Schönfeld. All rights reserved.
//

import Foundation

struct ReadData {
    
    static func readDataFromTextFile() -> String {
        
        var apiKey: String = ""
        
        if let path = Bundle.main.path(forResource: "api_key", ofType: "txt") {
            
            do {
                apiKey = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            } catch let err as NSError {
                print("Error: " + err.localizedDescription)
            }
        }
        return apiKey
    }
}
