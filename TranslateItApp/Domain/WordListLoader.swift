//
//  WordListLoader.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

import Foundation

protocol WordListLoader {
    func loadWords(completion: @escaping (WordList) -> Void)
}
