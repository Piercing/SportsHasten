//
//  ViewController.swift
//  SportHasten
//
//  Created by Juan Carlos Merlos Albarracín on 19/07/2019.
//  Copyright © 2019 devspain. All rights reserved.


import UIKit
import CircleMenu

class SportsViewController: UIViewController {
    
    // Properties
    @IBOutlet weak var goBtn: CircleMenu!
    @IBOutlet weak var aboutUsBtn: UIButton!
    var sportTitle: String?
    
    // API call
    let apiManager = APIManager()
    
    // Sotore data
    var footballPlayersFinal = [Players]()
    var formula1PlayersFinal = [Players]()
    var tenisPlayersFinal    = [Players]()
    var golfPlayersFinal     = [Players]()
    var joinedAllPlayers     = [Players]()
    
    var allSports            = [Sports]()
    var footballPlayers      = [Sports]()
    var formula1Players      = [Sports]()
    var tenisPlayers         = [Sports]()
    var golfPlayers          = [Sports]()
    
    var sportsTitles         = [String]()
    
    // UI Prpperties
    let items: [(icon: String, color: UIColor)] = [
        
        ("sports".localize,   UIColor(red: 1, green: 0.588, blue: 0, alpha: 1)),
        ("football".localize, UIColor(red: 1, green: 0.588, blue: 0, alpha: 1)),
        ("tenis".localize,    UIColor(red: 1, green: 0.588, blue: 0, alpha: 1)),
        ("golf".localize,     UIColor(red: 1, green: 0.588, blue: 0, alpha: 1)),
        ("f1".localize,       UIColor(red: 1, green: 0.588, blue: 0, alpha: 1))
    ]
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Animation circle menu button
        self.goBtn.flash()
        
    }
    
    // Setup UI
    func setupView() {
        
        setTitle(sportTitle ?? "Title".localize)
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "Avenir-Medium".localize, size: 25)!]
        goBtn.delegate = self
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9557052255, green: 0.4998359084, blue: 0.1469733715, alpha: 1)
        
        // Get sport if network available
        Utils.isConnectedToNetWork() ? getSports() : showAlert(message: "NoNetworkErrorMessage".localize)
        
    }
    
    // MARK:- UI Alert
    
    func showAlert(message:String) {
        
        let alertView = UIAlertController(title: title, message: message,  preferredStyle: .alert)
        let action = UIAlertAction(title: "OkButton".localize, style: .default, handler: { _ in self.goBtn.isEnabled = false })
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
        
    }
    
    // MARk: - Actions & Animations
    
    func springWithDampingCircleMenu() {
        
        self.goBtn.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: {  [weak self] in
                        self?.goBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            }, completion: { _ in
                UIView.animate(withDuration: 2.0) { self.goBtn.transform = CGAffineTransform.identity }
        })
        
    }
    
}

// MARK: - CircleMenuDelegate

extension SportsViewController: CircleMenuDelegate {
    
    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        
        button.backgroundColor = items[atIndex].color
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
        
        let highlightedImage = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
    }
    
    func circleMenu(_: CircleMenu, buttonWillSelected _: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
        
    }
    
    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        view.window?.layer.add(transition, forKey: kCATransition)
        
        let playersVC = UIStoryboard(name: "Main".localize, bundle:nil).instantiateViewController(
            withIdentifier: "PlayerViewController".localize) as! PlayerViewController
        
        if atIndex == 0 { playersVC.allPlayersSport = joinedAllPlayers }
        else if atIndex == 1 { playersVC.allPlayersSport = footballPlayersFinal }
        else if atIndex == 2 { playersVC.allPlayersSport = tenisPlayersFinal }
        else if atIndex == 3 { playersVC.allPlayersSport = golfPlayersFinal }
        else if atIndex == 4 { playersVC.allPlayersSport = formula1PlayersFinal }
        else { playersVC.allPlayersSport = joinedAllPlayers }
        
        playersVC.indexSport      = atIndex
        playersVC.allSportsTitles = self.sportsTitles
        
        self.navigationController?.pushViewController(playersVC, animated: true)
    }
    
}

/* TODO: This is posible to refactor at a View Model (MVVM)
 Is a small app, if it grows it will refactor MVVM */
extension SportsViewController {
    
    // MARK: - API Call
    
    private func getSports()  {
        
        apiManager.getSports() { (sport, error) in
            if let error = error {
                Utils.isConnectedToNetWork() ?
                    self.showAlert(message: "NoNetworkErrorMessage".localize) :
                    self.showAlert(message: "GetSportError \(error.localizedDescription)".localize)
                return
            }
            guard let fetchSports = sport else { return }
            
            // Get all sports
            self.allSports = fetchSports
            
            // Data Store
            self.fetchDiferentSporst()
        }
        
    }
    
    func fetchDiferentSporst() {
        
        // Get players of different sports
        footballPlayers  = allSports.filter { $0.title == "Football".localize }
        tenisPlayers     = allSports.filter { $0.title == "Tennis".localize }
        golfPlayers      = allSports.filter { $0.title == "Golf".localize }
        formula1Players  = allSports.filter { $0.title == "Formula1".localize }
        sportsTitles     = (allSports).map  { $0.title ?? "Sports".localize }
        
        // Stored diferent sports
        for (key, _) in footballPlayers.enumerated() { footballPlayersFinal = footballPlayers[key].players ?? [Players]() }
        for (key, _) in formula1Players.enumerated() { formula1PlayersFinal = formula1Players[key].players ?? [Players]() }
        for (key, _) in tenisPlayers.enumerated() { tenisPlayersFinal = tenisPlayers[key].players ?? [Players]() }
        for (key, _) in golfPlayers.enumerated() { golfPlayersFinal = golfPlayers[key].players ?? [Players]() }
        
        let joinedAllPlayersCollection = [footballPlayersFinal, formula1PlayersFinal, tenisPlayersFinal, golfPlayersFinal].joined()
        
        self.joinedAllPlayers = Array(joinedAllPlayersCollection)
        sportsTitles.insert("AllPlayers".localize, at: 0)
        
    }
    
}
