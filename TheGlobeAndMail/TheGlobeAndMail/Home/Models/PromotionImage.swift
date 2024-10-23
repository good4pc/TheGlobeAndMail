//
//  PromotionImage.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import Foundation

struct PromotionImagesUrl: Decodable {
    let image_650: String

    enum CodingKeys: String, CodingKey {
        case image_650 = "650"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.image_650 = try container.decode(String.self, forKey: .image_650)
    }

    init(image_650: String) {
        self.image_650 = image_650
    }
}

struct PromotionImage: Decodable {
    let urls: PromotionImagesUrl
}
