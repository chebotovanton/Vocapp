//
//  DefaultsManager.swift
//  Vocapp
//
//  Created by Anton Chebotov on 08/07/2017.
//  Copyright © 2017 vocapp. All rights reserved.
//

import Foundation

class DefaultsManager: NSObject {

    private static let kFirstHourKey = "kFirstHourKey"
    private static let kLastHourKey = "kLastHourKey"
    private static let kFirstLaunchDateKey = "kFirstLaunchDateKey"

    static func saveFirstHour(_ hour: HourObject) {
        let data = NSKeyedArchiver.archivedData(withRootObject: hour)
        UserDefaults.standard.set(data, forKey: kFirstHourKey)
    }

    static func saveLastHour(_ hour: HourObject) {
        let data = NSKeyedArchiver.archivedData(withRootObject: hour)
        UserDefaults.standard.set(data, forKey: kLastHourKey)
    }

    static func firstHour() -> HourObject {
        if let data = UserDefaults.standard.data(forKey: kFirstHourKey) {
            if let hour = NSKeyedUnarchiver.unarchiveObject(with: data) as? HourObject {
                return hour
            }
        }
        let defaultHour = HourObject(11)
        saveFirstHour(defaultHour)
        return defaultHour
    }

    static func lastHour() -> HourObject {
        if let data = UserDefaults.standard.data(forKey: kLastHourKey) {
            if let hour = NSKeyedUnarchiver.unarchiveObject(with: data) as? HourObject {
                return hour
            }
        }

        let defaultHour = HourObject(20)
        saveLastHour(defaultHour)
        return defaultHour
    }

    static func isFirstLaunch() -> Bool {
        if UserDefaults.standard.data(forKey: kFirstLaunchDateKey) != nil {
            return false
        }
        let date = Date()
        let data = NSKeyedArchiver.archivedData(withRootObject: date)
        UserDefaults.standard.set(data, forKey: kFirstLaunchDateKey)

        return true
    }

    static func daysSinceFirstStart() -> Int {
        if let data = UserDefaults.standard.data(forKey: kFirstLaunchDateKey) {
            let firstLaunchDate = NSKeyedUnarchiver.unarchiveObject(with: data) as! Date
            let timeInterval = Date().timeIntervalSince(firstLaunchDate)
            let dayLength: TimeInterval = 24 * 60 * 60

            return Int(timeInterval / dayLength)
        }

        return 0
    }
}
