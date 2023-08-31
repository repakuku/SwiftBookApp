//
//  ImageManager.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 8/31/23.
//

import Foundation

final class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImageData(from url: URL?) -> Data? {
        guard let url = url else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData
    }
}
