//
//  PlayersTableViewCell.swift
//  SportHasten
//
//  Created by Juan Carlos Merlos Albarracín on 19/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit
import SDWebImage

class PlayersTableViewCell: CeldableCell {
    
    // Properties
    @IBOutlet weak var imagePlayer: UIImageView!
    @IBOutlet weak var namePlayer: UILabel!
    @IBOutlet weak var surNamePlayer: UILabel!
    @IBOutlet weak var datePlayer: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        imagePlayer.layer.cornerRadius  = 45
        imagePlayer.layer.masksToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func set(obj: Any) {
        
        guard let obj = obj as? Players else { return }
        self.namePlayer.text = obj.name
        self.surNamePlayer.text = obj.surname
        
        guard let urlString = obj.image else { fatalError("Unexpected URL".localize) }
        let urlImage = URL(string: urlString)
        
        if obj.image != nil {
            imagePlayer.sd_setShowActivityIndicatorView(true)
            imagePlayer.sd_setIndicatorStyle(.gray)
            
            imagePlayer.sd_setImage(with: urlImage, placeholderImage: UIImage(named:"go"), options: [.refreshCached], completed: {
                (image, error, cache, url) in
                DispatchQueue.main.async {
                    self.imagePlayer.image = image
                }
            })
        }
        
        if let datePlayer = obj.date {
            self.datePlayer.text = datePlayer
        } else {
            self.datePlayer.text = "NoDate".localize
        }
        
    }
    
}
