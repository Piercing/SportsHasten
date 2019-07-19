//
//  SportsRootClass.swift
//  SportHasten
//
//  Created by Juan Carlos Merlos Albarracín on 19/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation

struct Sports: CeldableObject {
    var cellIdentifier: String { return PlayersTableViewCell.identifier }
    
    let players : [Players]?
    let title   : String?
    let type    : String?
    
}

extension Sports: Codable {
    
    enum CodingKeys: String, CodingKey {
        case players = "players"
        case title   = "title"
        case type    = "type"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        players    = try values.decodeIfPresent([Players].self, forKey: .players)
        title      = try values.decodeIfPresent(String.self, forKey: .title)
        type       = try values.decodeIfPresent(String.self, forKey: .type)
    }
    
}
