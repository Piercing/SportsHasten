//
//  StringExt.swift
//  SportHasten
//
//  Created by Juan Carlos Merlos Albarracín on 19/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation

extension String {
    
    var localize: String { return NSLocalizedString(self, comment: "") }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
