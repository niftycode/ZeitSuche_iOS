//
//  ArticleDate.swift
//  ZeitSuche
//
//  Created by Bodo Schönfeld on 26/06/16.
//  Copyright © 2016 Bodo Schönfeld. All rights reserved.
//

import Foundation

class ArticleDate {
    
    static func parseDate(date: String) -> String {
        
        // unformatted: 2015-11-19T02:04:31Z
        // formatted: 19. November 2015
        
        let unformattedDateIndex = date.startIndex.advancedBy(10)
        let unformattedDate = date.substringToIndex(unformattedDateIndex)
        
        var dateArray: [String] = unformattedDate.componentsSeparatedByString("-")
        
        let month: String = dateArray[1]
        
        switch month {
        case "01":
            dateArray[1] = "Januar"
        case "02":
            dateArray[1] = "Februar"
        case "03":
            dateArray[1] = "März"
        case "04":
            dateArray[1] = "April"
        case "05":
            dateArray[1] = "Mai"
        case "06":
            dateArray[1] = "Juni"
        case "07":
            dateArray[1] = "Juli"
        case "08":
            dateArray[1] = "August"
        case "09":
            dateArray[1] = "September"
        case "10":
            dateArray[1] = "Oktober"
        case "11":
            dateArray[1] = "November"
        case "12":
            dateArray[1] = "Dezember"
        default:
            print("missing month")
        }
        
        let formattedDate: String = dateArray[2] + ". " + dateArray[1] + " " + dateArray[0]
        return formattedDate
        
    }
}