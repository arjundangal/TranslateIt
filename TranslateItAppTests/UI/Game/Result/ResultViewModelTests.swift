//
//  ResultViewModelTests.swift
//  TranslateItAppTests
//
//  Created by Arjun Dangal on 25/7/2022.
//

import XCTest
@testable import TranslateItApp

class ResultViewModelTests: XCTestCase {
 
    func test_init_setsDataCorrectly() {
        let correctAttempts = 5
        let incorrectAttempts = 10
        let sut = ResultViewModel(correctAttempts: correctAttempts, incorrectAttempts: incorrectAttempts, startNewGame: { })
        
        XCTAssertEqual(sut.correctAnswers, "\(Constants.String.correct)\(correctAttempts)")
        XCTAssertEqual(sut.incorrectAnswers, "\(Constants.String.incorrect)\(incorrectAttempts)")
    }
    
}
