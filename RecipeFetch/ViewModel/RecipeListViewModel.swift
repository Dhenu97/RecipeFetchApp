//
//  RecipeListViewModel.swift
//  RecipeFetch
//
//  Created by dhenu on 5/29/25.
//
import SwiftUI

@MainActor
final class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var sortOption: SortOption = .name

    private let service: RecipeServiceProtocol

    init(service: RecipeServiceProtocol = RecipeService()) {
        self.service = service
    }

    func loadRecipes() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let fetched = try await service.fetchRecipes()
            guard !fetched.isEmpty else {
                throw FetchError.noRecipes
            }
            applySorting(to: fetched)
            errorMessage = nil
        } catch let error as FetchError {
            errorMessage = error.localizedDescription
            recipes = []
        } catch {
            errorMessage = FetchError.networkError.localizedDescription
            recipes = []
        }
    }

    func applySorting(to recipes: [Recipe]) {
        switch sortOption {
        case .name:
            self.recipes = recipes.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        case .cuisine:
            self.recipes = recipes.sorted { $0.cuisine.localizedCaseInsensitiveCompare($1.cuisine) == .orderedAscending }
        }
    }

    enum SortOption {
        case name, cuisine
    }
}
