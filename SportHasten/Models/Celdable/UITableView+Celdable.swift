//
//  UITableView+Celdable.swift
//  SportHasten
//
//  Created by Juan Carlos Merlos Albarracín on 19/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(_ celdable: CeldableCell.Type) {
        let nib = UINib(nibName: "\(celdable)", bundle: Bundle.main)
        self.register(nib, forCellReuseIdentifier: celdable.identifier)
    }
    
    func dequeueReusableCell(_ celdableObject: CeldableObject, _ indexPath: IndexPath) -> CeldableCell {
        let cell = self.dequeueReusableCell(withIdentifier: celdableObject.cellIdentifier, for: indexPath) as! CeldableCell
        cell.set(obj: celdableObject)
        return cell
    }
    
}
