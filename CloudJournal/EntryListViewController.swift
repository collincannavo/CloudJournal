//
//  EntryListViewController.swift
//  CloudJournal
//
//  Created by Collin Cannavo on 6/22/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import UIKit

class EntryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - UI Actions
    
    @IBAction func postButtonTapped(_ sender: Any) {

      
    }
    
    //MARK: - Properties
    
    
    
    
    //MARK: - View Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(refresh), name: EntryController.DidRefreshNotification, object: nil)
        
    }
    
    func refresh(_ notification: Notification) {
        tableView.reloadData()
        
    }
    
    
    //MARK: - TableView Datasource/Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.entryCellKey) else { return UITableViewCell() }
        
        let entries = EntryController.shared.entries
        let entry = entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
    
        return cell
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let textField = textField.text else { return }
        
        if segue.identifier == "toEntry" {
           
            guard let entryTitle = self.textField?.text else {
                return
            }
            
            if let destintationVC = segue.destination as? EntryDetailViewController,
            
                let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                
                let entries = EntryController.shared.entries
                
                let entry = entries[selectedIndexPath.row]
                
                destintationVC.entryTitleString = entryTitle
                destintationVC.entry = entry
            }
        } else if textField.isEmpty == true {
            
            let alertController = UIAlertController(title: "Please enter a Title", message: "You must enter a title before you can make a new journal entry", preferredStyle: .actionSheet)
            
            let okButton = UIAlertAction(title: "Okey-Dokie", style: .default, handler: nil)
            
            alertController.addAction(okButton)
            
            present(alertController, animated: true, completion: nil)
            
            return
            
        }
    }
    
}






