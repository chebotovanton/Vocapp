import WatchKit
import Foundation
import WatchConnectivity

class WordsIC: WKInterfaceController, WCSessionDelegate {

    let kRowType = "WordRow"

    @IBOutlet weak var tableView: WKInterfaceTable!
    private var session: WCSession?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        setTitle("Words")

        loadSeenWordsFromParent()
    }

    override func willActivate() {
        super.willActivate()
    }

    private func reloadTable(_ words: [WordExample]) {
        tableView.setNumberOfRows(words.count, withRowType: kRowType)
        for i in 0..<tableView.numberOfRows {
            let row = tableView.rowController(at: i)
            if let row = row as? WordRow {
                row.word = words[i]
            }
        }
    }

    private func loadSeenWordsFromParent() {
        if WCSession.isSupported() {
            session = WCSession.default()
            session?.delegate = self
            if session?.activationState == .activated {
                sendMessage()
            } else {
                session?.activate()
            }
        }
    }

    private func sendMessage() {
        self.session?.sendMessage(["message" : "text"], replyHandler: { (response) in
            let rawWords = response["seenWords"] as! [[String : String]]
            var result: [WordExample] = []
            for rawWord in rawWords {
                result.append(WordExample.fromDict(rawWord))
            }
            DispatchQueue.main.async {
                self.reloadTable(result)
            }
        }) { (err) in
            NSLog("error")
        }
    }

    // MARK: - WCSessionDelegate

    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        sendMessage()
    }

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        NSLog("user info")
    }
}
