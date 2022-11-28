//
//  ExtensionDecodable.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 27/11/22.
//

import Foundation

public extension Decodable {
    
    private static var modifyReadDecoder: JSONDecoder {
        let lobDecoderData = JSONDecoder()
        return lobDecoderData
    }
    
    init?(asJsonString: String) {
        guard let lobData = asJsonString.data(using: .utf8) else {
            return nil
        }
        
        do {
            self = try Self.modifyReadDecoder.decode(Self.self, from: lobData)
        } catch {
            debugPrint("Decodable error \(error)")
            return nil
        }
    }
}
