import WatchKit
import Foundation


class WordsIC: WKInterfaceController {

    let kRowType = "WordRow"

    @IBOutlet weak var tableView: WKInterfaceTable!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        setTitle("Words")

        let words = fakeWords()

        tableView.setNumberOfRows(words.count, withRowType: kRowType)
        for i in 0..<tableView.numberOfRows {
            let row = tableView.rowController(at: i)
            if let row = row as? WordRow {
                row.word = words[i]
            }
        }
    }

    private func fakeWords() -> [WordExample] {
        return [WordExample(text: "one", translation: "one"),
                WordExample(text: "two", translation: "two"),
                WordExample(text: "one", translation: "one"),
                WordExample(text: "one", translation: "one")]
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
