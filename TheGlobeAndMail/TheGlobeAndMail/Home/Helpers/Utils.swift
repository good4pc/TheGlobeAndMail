//
//  Utils.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import Foundation

struct Utils {
    static func makeTitle(authors: [String]) -> String {
        return getTitle(authors: authors)
    }

    private static func getTitle(authors: [String], pos: Int = 0) -> String {
        if authors.count == 1 {
            return authors[0]
        } else if pos > authors.count - 1 {
            return ""
        } else {
            let appendingTerm = pos == authors.count - 2 ? " and " : (pos < authors.count - 1 ? ", " : "")
            return authors[pos] + appendingTerm + getTitle(authors: authors, pos: pos + 1)
        }
    }
}
