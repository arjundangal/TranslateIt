//
//  WordsMapperTests.swift
//  TranslateItAppTests
//
//  Created by Arjun Dangal on 23/7/2022.
//

import XCTest
@testable import TranslateItApp

class WordsMapperTests: XCTestCase {
    
    func test_wordsMapper_throwsError_whenMalformedJsonIsProvided() {
        let invalidData = Data("Invalid Data".utf8)
        XCTAssertThrowsError(try WordsMapper.map(data: invalidData))
    }
    
    func test_wordsMapper_mapsCorrectly_whenCorrectJsonIsProvided() throws {
        let item1 = makeData(english: "English", spanish: "Espanyol")
        let item2 = makeData(english: "Translate", spanish: "SpanishTranslate")
        
        let result = try WordsMapper.map(data: makeItemsJSON([item1.json, item2.json]))
        
        XCTAssertEqual(result, [item1.item, item2.item])
        
    }
    
    
    //MARK: - Helpers
    
    private func makeData(english: String,
                          spanish: String) -> (item: WordPair, json: [String: Any]) {
        let item = WordPair(originalWord: english, translatedWord: spanish)
        let data = [
            "text_eng": english,
            "text_spa": spanish
        ]
        return (item,data)
     }
    
    func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        return try! JSONSerialization.data(withJSONObject: items)
    }
    
}
