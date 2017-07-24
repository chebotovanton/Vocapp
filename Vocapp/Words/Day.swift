import UIKit

private let kNumberKey = "number"
private let kWordsKey = "words"

class Day: NSObject {
    let words: [WordExample]
    let number: Int

    public init(number: Int, words: [WordExample]) {
        self.number = number
        self.words = words
    }

    public func title() -> String {
        return "DAY " + String(number + 1)
    }

    public func toDict() -> [String : Any] {
        var wordsArray: [[String : String]] = []
        for word in words {
            wordsArray.append(word.toDict())
        }
        return [kNumberKey : String(number), kWordsKey : wordsArray]
    }

    static public func fromDict(_ dict: [String : Any]) -> Day {
        let number = Int(dict[kNumberKey] as! String)!
        let rawWords = dict[kWordsKey] as! [[String : String]]
        var words: [WordExample] = []
        for rawWord in rawWords {
            words.append(WordExample.fromDict(rawWord))
        }

        return Day(number: number, words: words)
    }

}
