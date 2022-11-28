//
//  PersistenceData.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 27/11/22.
//

import Foundation

class PersistenceData {
    let userDefaults = UserDefaults.standard
    
    func savePost( name: String?) {
        guard let nameData =  name else {
            return
        }
        userDefaults.set(nameData, forKey: nameData)
    }
    
    func removeIdPost(name: String) {
        userDefaults.removeObject(forKey: name)
    }
    
}
