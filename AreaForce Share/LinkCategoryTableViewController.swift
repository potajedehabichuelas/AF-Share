//
//  LinkCategoryTableViewController.swift
//  
//
//  Created by Daniel Bolivar herrera on 08/02/2018.
//

import UIKit

protocol ShareSelectCategoryDelegate: class {
    func selected(category: AFLinkCategory)
}

class LinkCategoryTableViewController: UITableViewController {
    
    weak var delegate: ShareSelectCategoryDelegate?
    let reuseIdentifier = "categoryCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        title = "Selecciona Categoria"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    
        cell.textLabel?.text = AFLinkCategory.allValues[indexPath.row].string()
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.selected(category: AFLinkCategory.allValues[indexPath.row])
        }
    }
}
