//
//  AsyncImageView.swift
//  RecipeFetch
//
//  Created by dhenu on 5/29/25.
//

import SwiftUI

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    let imageCache: ImageCacheProtocol

    @State private var image: UIImage? = nil

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(ProgressView())
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        guard let url = url else { return }
        Task {
            image = await imageCache.loadImage(from: url)
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
            Text("No recipes found")
                .font(.title3)
                .foregroundColor(.gray)
            Text("Please try refreshing or check your connection.")
                .font(.subheadline)
                .foregroundColor(.gray.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
