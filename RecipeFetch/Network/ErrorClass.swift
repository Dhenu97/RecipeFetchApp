//
//  ErrorClass.swift
//  RecipeFetch
//
//  Created by dhenu on 5/29/25.
//

import Foundation

enum FetchError: Error, LocalizedError {
    case invalidResponse
    case networkError
    case noRecipes

    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Data is invalid."
        case .networkError: return "Network error occurred."
        case .noRecipes: return "No recipes available."
        }
    }
}
