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
        let items1 = [WordExample(text: "Text", translation: "Текст"), WordExample(text: "House", translation: "Дом"), WordExample(text: "Cat", translation: "Кошка")]
        let items2 = [WordExample(text: "Chair", translation: "Стул"), WordExample(text: "Table", translation: "Стол")]

        return [items1, items2]
    }
}
