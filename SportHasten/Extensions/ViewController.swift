//
//  ViewController.swift
//  SportHasten
//
//  Created by Juan Carlos Merlos Albarracín on 19/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

extension UIViewController {
    func setTitle(_ title: String) {
        
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.textColor = .black
        titleLbl.font = UIFont(name: "Avenir-Medium", size: 25)
        titleLbl.adjustsFontSizeToFitWidth = true
        titleLbl.minimumScaleFactor = 0.8
        titleLbl.numberOfLines = 0
        
        let titleView = UIStackView(arrangedSubviews: [titleLbl])
        titleView.axis = .horizontal
        titleView.spacing = 10.0
        navigationItem.titleView = titleView
    }
    
}

extension UIViewController {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
