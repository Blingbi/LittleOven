//
//  AuthManager.swift
//  Little Oven V3
//
//  Created by MacPro on 10/19/20.
//

import FirebaseDatabase
import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    //Mark: public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping(Bool)->Void){
        /*
         check if username is availble
         check if email is availble
         
         */
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: username){
            canCreate in
            if canCreate{
                /*
                 create acount
                 insert acount to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        // Firebase auth could not create acount
                        completion(false)
                        return
                    }
                    
                    //Insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            //succeded insert
                            completion(true)
                            return
                        }
                        else{
                            //failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {
                // username or email dont exist
                completion(false)
            }
        }
    }
    
    public func LoginUser(username: String?, email: String?, password: String,completion :@escaping(Bool) -> Void){
        if let email = email{
            //email log in
            Auth.auth().signIn(withEmail: email,password: password) {
                authResult, error in
                guard authResult != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username{
            //username log in
            print(username)
        }
        
    }
    
    public func logOut(completion: (Bool) -> Void){
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch{
            completion(false)
            print(error)
            return
        }
    }
    
}
