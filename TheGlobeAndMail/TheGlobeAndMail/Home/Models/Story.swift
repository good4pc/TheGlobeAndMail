//
//  HomePageModel.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import Foundation



struct Recommendations: Decodable {
    let recommendations: [Story]
}

struct Story: Decodable, Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(content_id)
    }

    static func == (lhs: Story, rhs: Story) -> Bool {
        lhs.content_id == rhs.content_id
    }

    let content_id: String
    let title: String
    let protection_product: String
    let author: Author
    let storyImage: PromotionImage

    var showTrailingIcon: Bool {
        protection_product == "red"
    }

    enum CodingKeys: String, CodingKey {
        case content_id = "content_id"
        case title = "title"
        case protection_product = "protection_product"
        case author = "byline"
        case storyImage = "promo_image"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.content_id = try container.decode(String.self, forKey: .content_id)
        self.title = try container.decode(String.self, forKey: .title)
        self.protection_product = try container.decode(String.self, forKey: .protection_product)
        self.author = try container.decode(Author.self, forKey: .author)
        self.storyImage = try container.decode(PromotionImage.self, forKey: .storyImage)
    }

    init(content_id: String,
         title: String,
         protection_product: String,
         author: Author,
         storyImage: PromotionImage) {
        self.content_id = content_id
        self.title = title
        self.protection_product = protection_product
        self.author = author
        self.storyImage = storyImage
    }
}
