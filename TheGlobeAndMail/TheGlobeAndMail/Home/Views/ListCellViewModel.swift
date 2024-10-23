//
//  ListCellViewModel.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import SwiftUI

final class ListCellViewModel: ObservableObject {
    private let cache = NSCache<NSString, UIImage>()
    private(set) var story: Story
    @Published var storyImage = UIImage()
    init(story: Story) {
        self.story = story
        downloadImage()
    }

    private func downloadImage() {
        if let existingImage = cache.object(forKey: NSString(string: story.storyImage.urls.image_650)) {
            self.storyImage = existingImage
        }  else {
            Task {
                await downloadAndSetImage()
            }
        }
    }

    private func downloadAndSetImage() async {
        let image = await ImageDownloader.downloadImage(url: story.storyImage.urls.image_650)
        DispatchQueue.main.async {
            if let image {
                self.cache.setObject(image, forKey: NSString(string: self.story.storyImage.urls.image_650))
                self.storyImage = image
            }
        }
    }
}
