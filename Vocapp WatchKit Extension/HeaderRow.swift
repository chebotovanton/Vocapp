import WatchKit

class HeaderRow: NSObject {
    @IBOutlet weak var textLabel: WKInterfaceLabel?

    var day: Day! {
        didSet {
            textLabel?.setText(day.title())
        }
    }
}
