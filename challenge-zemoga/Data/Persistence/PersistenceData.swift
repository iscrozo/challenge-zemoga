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
        let encoder = JSONEncoder()
        let data = json(from: postData)
//        if let encoded = try? encoder.encode(postData){
//            userDefaults.set(encoded, forKey: keyPostListDefault)
//        }
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
//        let decoder = JSONDecoder()
//        if let decodeData = try? decoder.decode(ArrayPost, from: getPostList) {
//            print(decodeData)
////            return decodeData
//        }
        return []
    }
    
    func synchronizeDefault() {
        userDefaults.synchronize()
    }

}
