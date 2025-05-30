//
//  RecipeDetailView.swift
//  RecipeFetch
//
//  Created by dhenu on 5/29/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    let imageCache: ImageCacheProtocol

    @State private var fullImage: UIImage? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let image = fullImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .shadow(radius: 5)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 200)
                        .overlay(ProgressView())
                }

                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text("Cuisine: \(recipe.cuisine)")
                    .font(.headline)
                    .foregroundColor(.secondary)

              VStack {
                  youtubeLinkView
              }

                Spacer()
            }
            .padding()
            .task {
                if let url = recipe.photoURLLarge {
                    fullImage = await imageCache.loadImage(from: url)
                }
            }
        }
        .navigationTitle("Details")
    }

  var youtubeLinkView: some View {
      if let youtubeURL = recipe.youtubeURL {
          print("YouTube URL: \(youtubeURL)")
          return AnyView(
              Link("Watch on YouTube", destination: youtubeURL)
                  .font(.body)
                  .foregroundColor(.blue)
                  .padding(.top, 4)
          )
      } else {
          return AnyView(EmptyView())
      }
  }
}


#Preview {
    ContentView()
}


