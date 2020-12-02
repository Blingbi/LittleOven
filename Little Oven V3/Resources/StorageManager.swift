//
//  StorageManager.swift
//  Little Oven V3
//
//  Created by MacPro on 10/19/20.
//

import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum LOStorageManagerError: Error {
        case failedToDownload
    }
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void){
        
    }
    
    public func downloadImage(with reference: String,completion: @escaping (Result<URL,LOStorageManagerError>) ->Void){
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url,error ==  nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
    
}

