//
//  HomePageModel.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import Foundation

enum Author: Decodable {
    case author(String)
    case authors([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let name = try? container.decode(String.self) {
            self = .author(name)
        } else if let names = try? container.decode([String].self) {
            self = .authors(names)
        } else {
            throw DecodingError.typeMismatch(Author.self, .init(codingPath: decoder.codingPath,
                                                                debugDescription: "wrong type"))
        }
    }
}

struct Recommendations: Decodable {
    let recommendations: [Story]
}

struct PromotionImagesUrl: Decodable {
    let image_650: String

    enum CodingKeys: String, CodingKey {
        case image_650 = "650"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.image_650 = try container.decode(String.self, forKey: .image_650)
    }
}

struct PromotionImage: Decodable {
    let urls: PromotionImagesUrl
}

struct Story: Decodable {
    let title: String
    let protection_product: String
    let byline: Author
    let promo_image: PromotionImage
}
