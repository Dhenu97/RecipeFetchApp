//
//  ContentView.swift
//  RecipeFetch
//
//  Created by dhenu on 5/29/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecipeListViewModel()
    private let imageCache: ImageCacheProtocol = DiskImageCache.shared

    var body: some View {
      NavigationView {
              VStack {
                  Picker("Sort by", selection: $viewModel.sortOption) {
                      Text("Name").tag(RecipeListViewModel.SortOption.name)
                      Text("Cuisine").tag(RecipeListViewModel.SortOption.cuisine)
                  }
                  .pickerStyle(SegmentedPickerStyle())
                  .padding()
                  .onChange(of: viewModel.sortOption) { _ in
                      viewModel.applySorting(to: viewModel.recipes)
                  }

                  content
              }
              .navigationTitle("Recipes")
              .task { await viewModel.loadRecipes() }
          }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            VStack {
                ProgressView("Loading...")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = viewModel.errorMessage {
            VStack {
                Text(error)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if viewModel.recipes.isEmpty {
            VStack {
                Text("No recipes available.")
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List(viewModel.recipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe, imageCache: imageCache)) {
                    RecipeRow(recipe: recipe, imageCache: imageCache)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            .refreshable {
                await viewModel.loadRecipes()
            }
        }
    }
}

#Preview {
    ContentView()
}


struct RecipeRow: View {
    let recipe: Recipe
    let imageCache: ImageCacheProtocol

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                AsyncImageView(url: recipe.photoURLSmall, imageCache: imageCache)
                    .frame(width: 60, height: 60)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 2)
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.headline)
                    Text(recipe.cuisine)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.leading, 4)
            }
//            Divider()

        }
        .padding(.vertical, 4)
    }
}


