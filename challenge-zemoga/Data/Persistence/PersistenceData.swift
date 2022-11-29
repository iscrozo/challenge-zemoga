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
        do {
            let data = try encoder.encode(postData)
            userDefaults.set(data, forKey: keyPostListDefault)
            
        } catch {
            print("error al guardar registro")
        }
        
        synchronizeDefault()
    }
    
    func getPostByUser() -> ArrayPost {
        let decoder = JSONDecoder()
       
       if let getPostList = userDefaults.data(forKey: keyPostListDefault) {
           do {
               let getPost = try decoder.decode([Post].self, from: getPostList)
               return getPost
           } catch {
               print("error al traer el registro")
           }
        }

        return []
    }
    
    func trySavePost( postData: Post) -> Bool {
        var data = getPostByUser()
        let newValue = data.filter({ $0.id == postData.id})
        if newValue.count > 0 {
            return false
        } else {
            data.append(postData)
            savePost(postData: data)
            return true
        }
    }
    
    func deletePostId(postData: Post) {
        var data = getPostByUser()
        if let removeData = data.firstIndex(where: { $0.id == postData.id}) {
            data.remove(at: removeData)
        }
        savePost(postData: data)
    }
    
    func removeAllPost() {
        userDefaults.removeObject(forKey: keyPostListDefault)
        synchronizeDefault()
    }
    
    func synchronizeDefault() {
        userDefaults.synchronize()
    }

}
