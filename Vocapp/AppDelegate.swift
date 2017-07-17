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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Fabric.with([Crashlytics.self])
        NotificationsManager.shared.authorize()

        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

//        let string = "A short description of the reason for the alert.\nUse this property to specify the title of your notification alert. If this property is set and your app successfully obtained authorization for the alert option, the system tries to display a notification alert.\nTitle strings should be short, usually only a couple of words describing the reason for the notification. In watchOS, the title string is displayed as part of the short look notification interface, which has limited space."
//        NotificationsManager.shared.setNotificationAfter(interval: 5,
//                                                         title: "",
//                                                         subtitle: "",
//                                                         body: "After weeks of negotiations an agreement was reached ✅\n\nПосле нескольких недель переговоров соглашение было достигнуто")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

