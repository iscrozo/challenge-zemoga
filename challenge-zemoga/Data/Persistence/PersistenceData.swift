//
//  PersistenceData.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 27/11/22.
//

import Foundation

class PersistenceData {
    let userDefaults = UserDefaults.standard
    
    func savePost( postData: ArrayPost) {
        userDefaults.set(postData, forKey: keyPostListDefault)
        synchronizeDefault()
    }
    
    func removePost(name: String) {
        userDefaults.removeObject(forKey: keyPostListDefault)
        synchronizeDefault()
    }
    
    func getPostByUser() -> ArrayPost {
        guard let getPostList = userDefaults.string(forKey: keyPostListDefault) else {
            return []
        }
        return getPostList as! ArrayPost
    }
    
    func synchronizeDefault() {
        userDefaults.synchronize()
    }
    
}
