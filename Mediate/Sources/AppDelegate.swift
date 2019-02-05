//
//  AppDelegate.swift
//  Mediate
//
//  Created by Ahmet Karalar on 4.02.2019.
//  Copyright © 2019 Ahmet Karalar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let controller = ScrollingTabController(underlayController: CameraFeedController(), tabItems: Icon.allCases.map(TabItem.init(icon:)))
    window?.rootViewController = controller
    window?.makeKeyAndVisible()
    return true
  }
}

