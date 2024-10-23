//
//  ImageDownloader.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import UIKit

class ImageDownloader {
    static func downloadImage(url: String) async -> UIImage? {
        guard let url = URL(string: url) else {
            return nil
        }
        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}
