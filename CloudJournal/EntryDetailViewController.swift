//
//  EntryDetailViewController.swift
//  CloudJournal
//
//  Created by Collin Cannavo on 6/22/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    
    @IBOutlet weak var entryTitle: UILabel!
    @IBOutlet weak var textBody: UITextView!
    
    var entry: Entry?
    var entryTitleString: String?
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let entryTitle = entryTitle.text,
            let textBody = textBody.text,
            !textBody.isEmpty else { return }
        
        let entry = Entry(title: entryTitle, timestamp: Date(), text: textBody)
        
        EntryController.shared.post(entry: entry)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        guard let entryTitleString = entryTitleString else { return }
        entryTitle.text = entryTitleString
        
        // Do any additional setup after loading the view.
    }

}
