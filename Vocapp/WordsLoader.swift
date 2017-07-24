//
//  WordsLoader.swift
//  Vocapp
//
//  Created by Aviasales on 28/06/2017.
//  Copyright © 2017 vocapp. All rights reserved.
//

import UIKit

class WordsLoader: NSObject {

    static let shared = WordsLoader()

    func loadWords() -> [[WordExample]] {
        let lines = loadStrings()
        var result: [[WordExample]] = []
        var i = 0
        var dayWords: [WordExample] = []
        while i < lines.count - 1 {
            let text = lines[i]
            let translation = lines[i+1]

            if text == "" {
                result.append(dayWords)
                dayWords = []
                i += 1
            } else {
                dayWords.append(WordExample(text: text, translation: translation))
                i += 2
            }
        }

        result.append(dayWords)

        return result
    }

    func loadStrings() -> [String] {
        do {
            if let path = Bundle.main.path(forResource: "Words", ofType: "txt"){
                let text = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                let lines = text.components(separatedBy: "\n")
                return lines
            }
        } catch _ {
            return []
        }
        return []
    }

    public func wordsSeenByUser() -> [[WordExample]] {
        let allWords = WordsLoader.shared.loadWords()
        let daysSinceFirstStart = DefaultsManager.daysSinceFirstStart()
        let seenWords = Array(allWords[0...daysSinceFirstStart])

        return seenWords
    }
}
