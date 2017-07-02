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
                self.setScheduledNotifications()
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
        let words = WordsLoader.shared.loadWords()
        var offset: TimeInterval = 0
        for dayWords in words {
            for word in dayWords {
                offset += 5
                setNotificationAfter(interval: offset, title: word.text, body: word.translation)
            }
            offset += 60
        }
    }

    private func setScheduledNotifications(_ first: Date, last: Date) {
        let words = WordsLoader.shared.loadWords()
        var offset: TimeInterval = first.timeIntervalSinceNow
        let dayLength: TimeInterval = 24 * 60 * 60
        for dayWords in words {
            for word in dayWords {
                offset += 5
                setNotificationAfter(interval: offset, title: word.text, body: word.translation)
            }
            offset += dayLength
        }
    }
}
