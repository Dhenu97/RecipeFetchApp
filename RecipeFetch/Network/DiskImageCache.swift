//
//  DiskImageCache.swift
//  RecipeFetch
//
//  Created by dhenu on 5/29/25.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
    func loadImage(from url: URL) async -> UIImage?
}

final class DiskImageCache: ImageCacheProtocol {
    static let shared = DiskImageCache()
    private let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]

    func loadImage(from url: URL) async -> UIImage? {
        let filePath = cacheDir.appendingPathComponent(url.lastPathComponent)
        if let data = try? Data(contentsOf: filePath), let image = UIImage(data: data) {
            return image
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            try? data.write(to: filePath)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}
