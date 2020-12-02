//
//  DatabaseManager.swift
//  Little Oven V3
//
//  Created by MacPro on 10/19/20.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    //Mark: public
    
    /// Check if username and email is availble
    /// - Parameters
    /// - email: String representing email
    /// - username: String representing username
    public func canCreateNewUser(with email : String, username: String, completion: (Bool)-> Void){
        completion(true)
        ///inserts new user data to database
        /// - Parameters
        /// - email: String representing email
        /// - username: String representing username
    }
    public func insertNewUser(with email : String, username : String, completion: @escaping(Bool)->Void){
        database.child(email.safeDatabaseKey()).setValue(["username" : username]) { error, _ in
            if error == nil {
                //succeded
                completion(true)
                return
            }
            else{
                completion(false)
                return
                //failed
            }
        }
    }
    // mark private
    
    
}
