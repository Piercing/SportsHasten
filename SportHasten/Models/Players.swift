//
//  SportsPlayer.swift
//  SportHasten
//
//  Created by Juan Carlos Merlos Albarracín on 19/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation

struct Players : CeldableObject  {
    var cellIdentifier: String { return PlayersTableViewCell.identifier }
    
    let image   : String?
    let name    : String?
    let surname : String?
    let date    : String?
    
}

extension Players: Codable {
    enum CodingKeys: String, CodingKey {
        case image   = "image"
        case name    = "name"
        case surname = "surname"
        case date    = "date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image   = try values.decodeIfPresent(String.self, forKey: .image)
        name    = try values.decodeIfPresent(String.self, forKey: .name)
        surname = try values.decodeIfPresent(String.self, forKey: .surname)
        date    = try values.decodeIfPresent(String.self, forKey: .date)
    }
    
}
