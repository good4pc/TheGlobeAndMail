//
//  ImageCache.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import UIKit

class ImageCache {
    private static let cache = NSCache<NSString, UIImage>()
    static func getImage(key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }

    static func saveImage(image: UIImage, key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
}
