//
//  swift_ui_demoApp.swift
//  swift_ui_demo
//
//  Created by renwei on 2026/8/26.
//

import SwiftUI
import QTCommon

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        qtInit()
        registerLifecycleNotifications()
        return true
    }

    private func registerLifecycleNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }

    @objc private func didEnterBackground() {
        QTPageTracker.appDidEnterBackground()
    }

    @objc private func willEnterForeground() {
        QTPageTracker.appWillEnterForeground()
    }

    private func qtInit() {
        QTConfigure.setLogEnabled(true)
        QTConfigure.enableLogNeedForward(true)
        QTConfigure.setCustomDomain("您的收数域名CustomDomain", standbyDomain: nil)
        QTConfigure.initWithAppkey("您的APPkey", channel: "App Store")

        if let umid = QTConfigure.umidString() {
            print("umid = \(umid)")
        }
    }
}

@main
struct swift_ui_demoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
