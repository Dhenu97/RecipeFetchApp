//
//  RecipeServiceTests.swift
//  RecipeFetchTests
//
//  Created by dhenu on 5/29/25.
//

import XCTest
@testable import RecipeFetch

final class RecipeServiceTests: XCTestCase {

    func testFetchRecipesSuccess() async throws {
        // Arrange
        let service = RecipeService()

        // Act
        let recipes = try await service.fetchRecipes()

        // Assert
        XCTAssertFalse(recipes.isEmpty, "Expected recipes list to be non-empty.")
    }

    func testFetchRecipesMalformedData() async {
        // Arrange
        let service = MockRecipeService(endpoint: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!)

        // Act & Assert
        do {
            _ = try await service.fetchRecipes()
            XCTFail("Expected FetchError.malformedData but got success.")
        } catch FetchError.invalidResponse {
            // Expected error
        } catch {
            XCTFail("Expected FetchError.malformedData but got \(error).")
        }
    }

    func testFetchRecipesEmptyData() async {
        // Arrange
        let service = MockRecipeService(endpoint: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!)

        // Act
        do {
            let recipes = try await service.fetchRecipes()
            XCTAssertTrue(recipes.isEmpty, "Expected an empty list of recipes.")
        } catch {
            XCTFail("Expected empty data but got error: \(error)")
        }
    }
}

// MockRecipeService allows us to pass custom endpoints for testing
final class MockRecipeService: RecipeServiceProtocol {
    private let endpoint: URL

    init(endpoint: URL) {
        self.endpoint = endpoint
    }

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
