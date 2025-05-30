//
//  ImageCacheTests.swift
//  RecipeFetchTests
//
//  Created by dhenu on 5/29/25.
//

import XCTest
@testable import RecipeFetch

final class ImageCacheTests: XCTestCase {

  func testMockImageCaching() async {
          let cache = MockImageCache()
          let url = URL(string: "https://via.placeholder.com/150")! // URL irrelevant with mock

          let image = await cache.loadImage(from: url)
          XCTAssertNotNil(image, "Mock should return a placeholder image.")
      }

    func testInvalidURLReturnsNil() async {
        let cache = DiskImageCache.shared
        let invalidURL = URL(string: "https://invalid.url/image.jpg")!
        let image = await cache.loadImage(from: invalidURL)
        XCTAssertNil(image, "Image should be nil for invalid URL.")
    }
}

final class MockImageCache: ImageCacheProtocol {
    func loadImage(from url: URL) async -> UIImage? {
        UIImage(systemName: "photo")
    }
}
