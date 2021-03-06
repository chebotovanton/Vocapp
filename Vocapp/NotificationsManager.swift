import UIKit
import UserNotifications

protocol NotificationManagerDelegate: class {
    func notificationAccessGranted(_ granted: Bool)
}

class NotificationsManager: NSObject {

    static let shared = NotificationsManager()
    let hourLength: TimeInterval = 60 * 60
    weak var delegate: NotificationManagerDelegate?

    func authorize() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (success, error) in
            DispatchQueue.main.async {
                if success {
                    if DefaultsManager.isFirstLaunch() {
                        self.setScheduledNotifications()
                    }
                }
                self.delegate?.notificationAccessGranted(success)
            }
        }
    }

    func setNotificationAfter(interval: TimeInterval, title: String, body:String) {
        setNotificationAfter(interval: interval, title: title, subtitle: "", body: body)
    }

    func setNotificationAfter(interval: TimeInterval, title: String, subtitle: String, body:String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound(named: "notification.wav")
        if let att = attachmentSound() {
            content.attachments = [att]
        }

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: title+body, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (err) in
            if let error = err {
                NSLog(error.localizedDescription)
            }
        }
    }

    private func attachmentSound() -> UNNotificationAttachment? {
        if let url = Bundle.main.url(forResource: "kirov_reporting", withExtension: "mp3") {
            let att = try! UNNotificationAttachment(identifier: "sound", url: url, options: nil)
            return att
        }
        return nil
    }

    private func setScheduledNotifications() {
        let first = DefaultsManager.firstHour()
        let last = DefaultsManager.lastHour()
        setScheduledNotifications(first, last: last)
    }

    func setScheduledNotifications(_ first: HourObject, last: HourObject) {
        cancelAllNotifications()

        let daysGone = DefaultsManager.daysSinceFirstStart()

        let days = WordsLoader.shared.loadWords()
        let offsetToFirstDate = timeToFirstNotification(first)
        let firstToLastNotificationsInterval = TimeInterval(last.value - first.value) * hourLength
        let dayLength: TimeInterval = 24 * hourLength
        for i in daysGone..<days.count {
            let day = days[i]
            let dayWords = day.words
            var offset = offsetToFirstDate + TimeInterval(i) * dayLength
            let offsetBeetweenNotifications = firstToLastNotificationsInterval / TimeInterval(dayWords.count - 1)
            for word in dayWords {
                setNotificationAfter(interval: offset, title: word.text, body: word.translation)
                offset += offsetBeetweenNotifications
            }
        }
    }

    private func tomorrow(hour: HourObject) -> Date {
        let calendar = Calendar.current
        let now = Date()
        let comps: Set <Calendar.Component> = [.year, .month, .day, .hour, .minute, .second, .timeZone]

        var nowComponents = calendar.dateComponents(comps, from: now)
        nowComponents.day = nowComponents.day! + 1
        nowComponents.hour = hour.value
        nowComponents.minute = 0
        nowComponents.second = 0

        return calendar.date(from: nowComponents)!
    }

    private func timeToFirstNotification(_ first: HourObject) -> TimeInterval {
        let firstDate = tomorrow(hour:first)

        return firstDate.timeIntervalSinceNow
    }

    func hoursToFirstNotification() -> Int {
        let first = DefaultsManager.firstHour()
        let interval = timeToFirstNotification(first)


        return Int(interval / hourLength) + 1
    }

    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
