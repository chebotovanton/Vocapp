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

    static func saveFirstHour(_ hour: HourObject) {
        UserDefaults.standard.set(hour, forKey: kFirstHourKey)
    }

    static func saveLastHour(_ hour: HourObject) {
        UserDefaults.standard.set(hour, forKey: kLastHourKey)
    }

    static func firstHour() -> HourObject {
        if let hour = UserDefaults.standard.object(forKey: kFirstHourKey) as? HourObject {
            return hour
        }
        let defaultHour = HourObject(11)
        saveFirstHour(defaultHour)
        return defaultHour
    }

    static func lastHour() -> HourObject {
        if let hour = UserDefaults.standard.object(forKey: kLastHourKey) as? HourObject {
            return hour
        }
        let defaultHour = HourObject(20)
        saveLastHour(defaultHour)
        return defaultHour
    }
}
