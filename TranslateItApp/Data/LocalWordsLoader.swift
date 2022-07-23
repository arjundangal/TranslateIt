//
//  LocalWordsLoader.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

import Foundation

final class LocalWordsLoader: WordListLoader {
    
    func loadWords(url: URL, completion: @escaping (WordList) -> Void) {
        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            let wordList =  try WordsMapper.map(data: data)
            completion(wordList)
        }catch {
            completion([])
         }
    }
}
