//
//  Entry+CloudKit.swift
//  CloudJournal
//
//  Created by Collin Cannavo on 6/22/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation
import CloudKit

extension Entry {

    static var recordTypeKey: String { return "Entry" }
    static var entryTitleKey: String { return "Title" }
    static var timestampKey: String { return "Timestamp" }
    static var textKey: String { return "Text" }
    
    // MARK: - Init from CloudKit
    
    init?(cloudKitRecord: CKRecord) {
        
        guard let entryTitle = cloudKitRecord[Entry.entryTitleKey] as? String,
            let timestamp = cloudKitRecord[Entry.timestampKey] as? Date,
            let text = cloudKitRecord[Entry.textKey] as? String,
            cloudKitRecord.recordType == Entry.recordTypeKey else { return nil }
        
        self.init(title: entryTitle, timestamp: timestamp, text: text)
        
    }
    
    // MARK: - Property to save to CloudKit
    
    var cloudKitRecord: CKRecord {
        
        let record = CKRecord(recordType: Entry.recordTypeKey)
        
        record.setValue(text, forKey: Entry.textKey)
    
        record.setValue(title, forKey: Entry.entryTitleKey)
    
        record.setValue(timestamp, forKey: Entry.timestampKey)
        
        return record
    }
    
    
}
