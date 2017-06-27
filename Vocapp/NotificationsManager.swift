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
        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { (success, error) in }
    }

    func setNotificationAfter(interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "I am the notification"
        content.body = "Gotta be shown on your watch"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (err) in
            if let error = err {
                NSLog(error.localizedDescription)
            }
        }
    }
}
