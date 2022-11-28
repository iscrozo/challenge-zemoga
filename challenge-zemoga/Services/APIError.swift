//
//  APIError.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 27/11/22.
//

import Foundation

enum APIError: Error {
    case invalidRequest
    case invalidResponse
    case jsonParsingError(error: Error)
    case dataLoadingError(statusCode: Int, data: Data)
}
