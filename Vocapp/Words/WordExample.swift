import UIKit

private let kTextKey = "text"
private let kTranslationKey = "translation"

class WordExample: NSObject {
    let text: String
    let translation: String

    init(text: String, translation: String) {
        self.text = text
        self.translation = translation
    }

    public func toDict() -> [String : String] {
        return [kTextKey : text, kTranslationKey : translation]
    }

    static public func fromDict(_ dict: [String : String]) -> WordExample {
        let text = dict[kTextKey]!
        let translation = dict[kTranslationKey]!

        return WordExample(text: text, translation: translation)
    }
}
