//
//  RecipeService.swift
//  RecipeFetch
//
//  Created by dhenu on 5/29/25.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]
}

final class RecipeService: RecipeServiceProtocol {
    private let endpoint = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

    func fetchRecipes() async throws -> [Recipe] {
        let (data, _) = try await URLSession.shared.data(from: endpoint)
        do {
            let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return decoded.recipes
        } catch {
            throw FetchError.invalidResponse
        }
    }
}



