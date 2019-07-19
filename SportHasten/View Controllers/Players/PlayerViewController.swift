//
//  PlayerViewController.swift
//  SportHasten
//
//  Created by Juan Carlos Merlos Albarracín on 19/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    // Properties
    @IBOutlet weak var tableViewPlayers: UITableView!
    
    // Public Interface
    var allSportsTitles  = [String]()
    var indexSport       = Int()
    
    var allPlayersSport = [Players]() {
        didSet {
            self.reloadData()
        }
        
    }

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    // Setup UI
    func setupView() {
        self.tableViewPlayers.register(PlayersTableViewCell.self)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.942633043, green: 0.5137104261, blue: 0.141633043, alpha: 1)
        self.title = "Title".localize
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "Avenir-Medium".localize, size: 25)!]
        
        tableViewPlayers.separatorInset = UIEdgeInsets.zero
        tableViewPlayers.allowsMultipleSelection = true
        
    }
    
}

// MARK: - Table View Delegate & Data Source

extension PlayerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let obj = allSportsTitles[section]
        var view = tableView.dequeueReusableHeaderFooterView(withIdentifier: obj) as? AllPlayersTableViewHeader
        
        if view == nil { view = AllPlayersTableViewHeader.customView }
        view?.contentView.backgroundColor = UIColor(red:0.94, green:0.93, blue:0.96, alpha:1.0)
        
        if indexSport == 0 { view?.headerLabel.text = allSportsTitles[indexSport] }
        else if indexSport == 1 { view?.headerLabel.text = allSportsTitles[indexSport] }
        else if indexSport == 2 { view?.headerLabel.text = allSportsTitles[indexSport] }
        else if indexSport == 3 { view?.headerLabel.text = allSportsTitles[indexSport] }
        else if indexSport == 4 { view?.headerLabel.text = allSportsTitles[indexSport] }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let indexPathsForSelectedRows = tableView.indexPathsForSelectedRows ?? [IndexPath]()
        
        for selectedIndexPath in indexPathsForSelectedRows {
            if selectedIndexPath.section == indexPath.section {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
        
        return indexPath;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPlayersSport.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var obj: Players!
        obj = allPlayersSport[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(obj as CeldableObject, indexPath) as? PlayersTableViewCell
            else { fatalError("UnexpectedTVCell".localize) }
        
        return cell
    }
    
}

extension PlayerViewController {
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableViewPlayers.reloadData()
        }
    }
    
}
