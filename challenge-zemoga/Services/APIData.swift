//
//  APIData.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 27/11/22.
//

import Foundation

public enum APIData {
    case queryPostAll
    case queryUserId(userId: Int)
    case queryPostId(postId: Int)
    
    //MARK: protocol url
    var protocolURL: String {
        switch self {
        case .queryPostAll, .queryUserId, .queryPostId:
            return api_protocol
        }
    }
    
    //MARK: Api dominio name
    var dominioURL: String {
        switch self {
        case .queryPostAll, .queryUserId, .queryPostId:
            return api_domain_name
        }
    }
    
    //MARK: router url
    var routeURL: String {
        switch self {
        case .queryPostAll:
            return api_directory_path_post
        case .queryUserId:
            return api_directory_path_users
        case .queryPostId:
            return api_directory_path_comments
        }
    }
    
    //MARK: parameters url
    var parametersURL: [URLQueryItem] {
        switch self {
        case .queryPostAll:
            return [URLQueryItem(name: "", value: "")]
        case .queryUserId(let userId):
            return  [URLQueryItem(name: api_directory_path_users_id, value: "\(userId)")]
        case .queryPostId(let postId):
            return  [URLQueryItem(name: api_directory_path_comments_id, value: "\(postId)")]
        }
    }
    
    //MARK: type request
    var typeRequestURL: String {
        switch self{
        case .queryPostAll, .queryUserId, .queryPostId:
            return api_type_request_get
        }
    }
    
}
