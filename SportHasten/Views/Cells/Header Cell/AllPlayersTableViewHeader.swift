//
//  AllPlayersTableViewHeader.swift
//  SportHasten
//
//  Created by Juan Carlos Merlos Albarracín on 19/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

class AllPlayersTableViewHeader: UITableViewHeaderFooterView  {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class var customView: AllPlayersTableViewHeader {
        let cell = Bundle.main.loadNibNamed("AllPlayersTableViewHeader", owner: self, options: nil)?.last
        return cell as! AllPlayersTableViewHeader
        
    }
    
    
}
