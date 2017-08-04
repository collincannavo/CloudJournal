//
//  EntryController.swift
//  CloudJournal
//
//  Created by Collin Cannavo on 6/22/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation
import CloudKit

extension EntryController {
 
    // This is like creating a channel on a radio: or a code word
    static let DidRefreshNotification = Notification.Name("DidRefreshNotification")
    
}

class EntryController {

    // MARK: - Properties
    
    static let shared = EntryController()
    
    private let cloudKitManager = CloudKitManager()
    
    private(set) var entries = [Entry]() {
        didSet {
            DispatchQueue.main.async {
                let notificationCenter = NotificationCenter.default
                notificationCenter.post(name: EntryController.DidRefreshNotification, object: self)
            }
        }
    }

    // MARK: - View Lifecycle
    
    init() {
        fetchEntries()
    }
    
    // MARK: - CloudKit
    
    func post(entry: Entry, completion: @escaping ((Error?) -> Void) = {_ in } ) {
        
        let record = entry.cloudKitRecord
        
        cloudKitManager.save(record) { (error) in
            
            defer { completion(error) }
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.entries.append(entry)
        }
    }
    
    func fetchEntries(completion: @escaping ((Error?) -> Void) = { _  in } ) {
     
        let sortDescriptor = [NSSortDescriptor(key: Entry.timestampKey, ascending: true)]
        
        cloudKitManager.fetchRecords(ofType: Entry.recordTypeKey, sortDescriptors: sortDescriptor) { (records, error) in
            
            defer { completion(error) }
            
            if let error = error {
             NSLog("There was an error fetching the Entry: \(error.localizedDescription)")
                return
            }
            
            guard let records = records else { return }
            
            self.entries = records.flatMap { Entry(cloudKitRecord: $0) }
            
        }
    }
}





