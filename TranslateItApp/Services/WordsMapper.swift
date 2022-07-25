//
//  WordsMapper.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

import Foundation

final class WordsMapper {
    
    struct LocalWords: Codable {
        let english: String
        let spanish: String

        enum CodingKeys: String, CodingKey {
             case english = "text_eng"
             case spanish = "text_spa"
        }
        
        func toDomain() -> WordPair {
            return .init(originalWord: english, translatedWord: spanish)
        }
    }
    
    typealias LocalWordsList = [LocalWords]
    
    enum Error: Swift.Error {
        case invalidData
    }
 
    
    static func map(data: Data) throws -> WordList {
        guard let localWordsList = try? JSONDecoder().decode(LocalWordsList.self, from: data) else {
            throw Error.invalidData
        }
        return localWordsList.map{$0.toDomain()}
    }
}
