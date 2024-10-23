//
//  AuthorTests.swift
//  TheGlobeAndMailTests
//
//  Created by Prasanth pc on 2024-10-23.
//

import XCTest
@testable import TheGlobeAndMail

final class AuthorTests: XCTestCase {
    func test_display() {
        var author: Author = .author("")
        XCTAssertEqual(author.displayValue, "")
        
        author = .author("Prasanth")
        XCTAssertEqual(author.displayValue, "Prasanth")
        author = .authors(["Prasanth", "Sam"])
        XCTAssertEqual(author.displayValue, "Prasanth and Sam")
        
        author = .authors(["Prasanth", "Sam", "Kim"])
        XCTAssertEqual(author.displayValue, "Prasanth, Sam and Kim")

        author = .authors([])
        XCTAssertEqual(author.displayValue, "")
    }
}
