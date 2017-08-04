//
//  CloudKitManager.swift
//  CloudJournal
//
//  Created by Collin Cannavo on 6/22/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {

    let database = CKContainer.default().publicCloudDatabase
    
    //Fetch records
    func fetchRecords(ofType type: String, sortDescriptors: [NSSortDescriptor]? = nil, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        
        // Define your query
        let query = CKQuery(recordType: type, predicate: NSPredicate(value:true))
        // Predicates allow you go into your stored information and look for something really specific
        
        query.sortDescriptors = sortDescriptors
        
        database.perform(query, inZoneWith: nil, completionHandler: completion)
        
    }
    
    //Save record
    
    func save(_ record: CKRecord, completion: @escaping ((Error?)) -> Void = { _ in }) {
        
        database.save(record) { (record, error) in
            completion(error)
        }
    }
    
    // MARK: - CKSubscription
    
    func subscribeToCreationOfRecords(ofType type: String, completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        //this is what we are creating to save
        let subscription = CKQuerySubscription(recordType: type, predicate: NSPredicate(value: true), options: .firesOnRecordCreation)
        
        let notificationInfo = CKNotificationInfo()
        notificationInfo.alertBody = "There is a new message for you to see 👌"
        subscription.notificationInfo = notificationInfo
        
        // this is where we are putting in the database
        
        database.save(subscription) { (subscription, error) in
            
            if let error = error {
                NSLog("Error saving subscription: \(error)")
            }
            completion(error)
        }
        
    }
}

