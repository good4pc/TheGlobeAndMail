//
//  ListCellViewModel.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import SwiftUI

final class HomePageListCellViewModel: ObservableObject {
    private(set) var story: Story
    @Published var storyImage = UIImage()
    init(story: Story) {
        self.story = story
        downloadImage()
    }

    private func downloadImage() {
        if let existingImage = ImageCache.getImage(key: story.storyImage.urls.image_650) {
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
                ImageCache.saveImage(image: image, key: self.story.storyImage.urls.image_650)
                self.storyImage = image
            }
        }
    }
}
