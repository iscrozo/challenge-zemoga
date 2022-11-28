//
//  APIClient.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 27/11/22.
//

import Foundation

class APIClient {
    
    var requestBuilderURL: APIBuild?
    
    required init(requestBuilderURL : APIBuild){
        self.requestBuilderURL = requestBuilderURL
    }
    
    func requestData( apiData: APIData, completion: @escaping(Result<Any, Error>) -> ()) {
        
        guard let urlData = self.requestBuilderURL?.buildURL(apiData: apiData) else {
            return
        }
        
        let requestData = URLSession(configuration: .default)
        
        let resultData = requestData.dataTask(with: urlData) { data, response, error in
            if let lobData = data {
                if let lobResponse = response as? HTTPURLResponse {
                    if 200..<300 ~= lobResponse.statusCode {
                        do {
                            let responseData = try JSONSerialization.jsonObject(with: lobData, options: []) as? Any
                            guard let result = responseData else {
                                completion(.failure(APIError.invalidRequest))
                                return
                            }
                            switch apiData {
                            case .queryPostAll:
                                completion(.success(result))
                            case .queryUserId:
                                completion(.success(result))
                            case .queryPostId:
                                completion(.success(result))
                            }
                        }
                        catch {
                            completion(.failure(APIError.jsonParsingError(error: error)))
                        }
                    } else {
                        completion(.failure(APIError.dataLoadingError(statusCode: lobResponse.statusCode, data: lobData)))
                    }
                } else {
                    completion(.failure(APIError.invalidResponse))
                }
            } else {
                completion(.failure(APIError.invalidRequest))
            }
            
        }
        
        resultData.resume()
    }
    
}
