//
//  CeldableCell.swift
//  SportHasten
//
//  Created by Juan Carlos Merlos Albarracín on 19/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

typealias CeldableCell   = UITableViewCell & CeldableCellProtocol
protocol CeldableCellProtocol {
    
    static var identifier: String { get }
    
    func set(obj: Any)
    func setDelegate(delegate: Any)
    
}

extension CeldableCellProtocol {
    
    static var identifier: String { return "\(self)" }

    func setDelegate(delegate: Any) { }
}
