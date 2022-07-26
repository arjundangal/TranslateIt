//
//  GameState.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

import Foundation

enum GameState: Equatable {
    case question(data: GameData)
    case ended(result: GameResult)
 }

struct GameResult: Equatable {
   let correctAttempts: Int
   let incorrectAttempts: Int
}
