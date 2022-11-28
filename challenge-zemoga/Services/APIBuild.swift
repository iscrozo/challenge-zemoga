//
//  APIBuild.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 27/11/22.
//

import Foundation

class APIBuild {
    func buildURL(apiData: APIData) -> URLRequest? {
        var componentURL = URLComponents()
        componentURL.scheme = apiData.protocolURL
        componentURL.host = apiData.dominioURL
        componentURL.path = apiData.routeURL
        componentURL.queryItems = apiData.parametersURL
        
        guard let urlValue = componentURL.url else { return nil }
        
        var urlRequest = URLRequest(url: urlValue)
        urlRequest.httpMethod = apiData.typeRequestURL
        return urlRequest
    }
}
