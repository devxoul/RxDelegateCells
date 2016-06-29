//
//  AppDelegate.swift
//  Example
//
//  Created by Suyeol Jeon on 6/30/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

import ManualLayout
import Then

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = .whiteColor()
        self.window!.makeKeyAndVisible()

        let notificationListViewModel = NotificationListViewModel(api: API())
        let notificationListViewController = NotificationListViewController(viewModel: notificationListViewModel)
        let navigationController = UINavigationController(rootViewController: notificationListViewController)
        self.window!.rootViewController = navigationController

        return true
    }

}
