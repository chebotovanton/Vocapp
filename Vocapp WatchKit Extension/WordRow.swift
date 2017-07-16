import WatchKit

class WordRow: NSObject {

    @IBOutlet weak var textLabel: WKInterfaceLabel?
    @IBOutlet weak var translationLabel: WKInterfaceLabel?

    var word: WordExample? {
        didSet {
            if let newWord = self.word {
                textLabel?.setText(newWord.text)
                translationLabel?.setText(newWord.translation)
            }
        }
    }
}
