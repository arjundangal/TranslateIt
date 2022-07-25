//
//  LocalWordsLoaderTests.swift
//  TranslateItAppTests
//
//  Created by Arjun Dangal on 25/7/2022.
//

import XCTest
@testable import TranslateItApp

class LocalWordsLoaderTests: XCTestCase {

    func test_loadWords_loadsDataCorrectly() {
        let url =  URL(fileURLWithPath:  Bundle(for: LocalWordsLoaderTests.self).path(forResource: "test_words", ofType: "json")!)
        let sut = LocalWordsLoader(url: url)
        var result: WordList?
        let exp = expectation(description: "Waiting for load completion")
        sut.loadWords { wordList in
            result = wordList
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(result?.count, 2)
        XCTAssertEqual(result?.first?.originalWord, "primary school")
        XCTAssertEqual(result?.first?.translatedWord, "escuela primaria")
    }

}
