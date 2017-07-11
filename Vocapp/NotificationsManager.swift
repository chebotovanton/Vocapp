//
//  NotificationsManager.swift
//  Vocapp
//
//  Created by Aviasales on 27/06/2017.
//  Copyright © 2017 vocapp. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationsManager: NSObject {

    static let shared = NotificationsManager()

    func authorize() {
        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { (success, error) in
            DispatchQueue.main.async {
                if DefaultsManager.isFirstLaunch() {
                    self.setScheduledNotifications()
                }
            }
        }
    }

    func setNotificationAfter(interval: TimeInterval, title: String, body:String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: title+body, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (err) in
            if let error = err {
                NSLog(error.localizedDescription)
            }
        }
    }

    private func setScheduledNotifications() {
        let first = DefaultsManager.firstHour()
        let last = DefaultsManager.lastHour()
        setScheduledNotifications(first, last: last)
    }

    func setScheduledNotifications(_ first: HourObject, last: HourObject) {
        cancelAllNotifications()

        let words = WordsLoader.shared.loadWords()
        let firstDate = tomorrow(hour:first)
        let offsetToFirstDate = firstDate.timeIntervalSinceNow
        let firstToLastNotificationsInterval = TimeInterval((last.value - first.value) * 60 * 60)
        let dayLength: TimeInterval = 24 * 60 * 60
        for i in 0..<words.count {
            let dayWords = words[i]
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

    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
