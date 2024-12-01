import Foundation
import CloudKit

class CloudKitHelper {
    
    private let privateDatabase = CKContainer.default().privateCloudDatabase
    
    func save(recordType: String, fields: [String: Any], completion: @escaping (Result<CKRecord, Error>) -> Void) {
        let record = CKRecord(recordType: recordType)
        for (key, value) in fields {
            record.setValue(value, forKey: key)
        }
        
        privateDatabase.save(record) { savedRecord, error in
            if let error = error {
                completion(.failure(error))
            } else if let savedRecord = savedRecord {
                completion(.success(savedRecord))
            }
        }
    }
    
    func fetch(recordType: String, predicate: NSPredicate = NSPredicate(value: true), completion: @escaping (Result<[CKRecord], Error>) -> Void) {
        let query = CKQuery(recordType: recordType, predicate: predicate)
        
        privateDatabase.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                completion(.failure(error))
            } else if let records = records {
                completion(.success(records))
            }
        }
    }
    
    func update(record: CKRecord, fields: [String: Any], completion: @escaping (Result<CKRecord, Error>) -> Void) {
        for (key, value) in fields {
            record.setValue(value, forKey: key)
        }
        
        privateDatabase.save(record) { updatedRecord, error in
            if let error = error {
                completion(.failure(error))
            } else if let updatedRecord = updatedRecord {
                completion(.success(updatedRecord))
            }
        }
    }
    
    func delete(recordID: CKRecord.ID, completion: @escaping (Result<Void, Error>) -> Void) {
        privateDatabase.delete(withRecordID: recordID) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
