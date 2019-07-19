//
//  Utils.swift
//  SportHasten
//
//  Created by Juan Carlos Merlos Albarracín on 19/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation
import Reachability

class Utils {
    
    static func convertDataToString(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        guard let date = dateFormatter.date(from: date) else {
            print("Don't possible conversion.")
            return Date()
        }
        return date
        
    }
    
    static func convertStringToDate(date:Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.string(from: date)
        return newDate
        
    }
    
    static func isConnectedToNetWork() -> Bool {
        return (Reachability()?.connection != .none)
    }
    
}
