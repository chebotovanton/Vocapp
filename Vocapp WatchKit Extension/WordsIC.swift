import WatchKit
import Foundation
import WatchConnectivity

class WordsIC: WKInterfaceController, WCSessionDelegate {

    let kRowType = "WordRow"
    let kHeaderType = "HeaderRow"

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

    private func reloadTable(_ days: [Day]) {

        var rowTypes: [String] = []
        for day in days {
            rowTypes.append(kHeaderType)
            for _ in day.words {
                rowTypes.append(kRowType)
            }
        }
        tableView.setRowTypes(rowTypes)

        var index: Int = 0
        for day in days {
            let header = tableView.rowController(at: index) as! HeaderRow
            header.day = day
            index += 1
            for i in 0..<day.words.count {
                let word = day.words[i]
                let row = tableView.rowController(at: index) as! WordRow
                row.word = word
                index += 1
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
            let rawDays = response["seenWords"] as! [[String : Any]]
            var result: [Day] = []
            for rawDay in rawDays {
                result.append(Day.fromDict(rawDay))
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
