//
//  AppDelegate.swift
//  Vocapp
//
//  Created by Aviasales on 27/06/2017.
//  Copyright © 2017 vocapp. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Fabric.with([Crashlytics.self])
        NotificationsManager.shared.authorize()

        WCSession.default().delegate = self
        WCSession.default().activate()

        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }


    public func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Swift.Void) {
        let alert = UIAlertController(title: "Message", message: nil, preferredStyle: .alert)
        let vc = window?.rootViewController
        alert.show(vc!, sender: nil)

        let seenWords = WordsLoader.shared.wordsSeenByUser()
        var result: [[String : Any]] = []
        for day in seenWords {
            for word in day {
                result.append(word.toDict())
            }
        }
        replyHandler(["seenWords" : result])
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        NSLog("success")
    }

    func sessionDidDeactivate(_ session: WCSession) {
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
    }

    func sessionWatchStateDidChange(_ session: WCSession) {
        NSLog("state changed")
    }
}

