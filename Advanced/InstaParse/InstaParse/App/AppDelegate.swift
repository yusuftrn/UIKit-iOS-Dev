//
//  AppDelegate.swift
//  InstaParse
//
//  Created by Yusuf Turan on 7.07.2021.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    let config = ParseClientConfiguration { ParseMutableClientConfiguration in
      ParseMutableClientConfiguration.applicationId = "grdOEJsditfUxYzxYawUXFlB5zkStNiPa7kaTxF0"
      ParseMutableClientConfiguration.clientKey = "uL0h5UHyF2wvx5s0aQesQLvSJkCofTQubxjeYVAA"
      ParseMutableClientConfiguration.server = "https://parseapi.back4app.com/"
    }
    Parse.initialize(with: config)
    
    let defaultACL = PFACL()
    defaultACL.hasPublicReadAccess = true
    defaultACL.hasPublicWriteAccess = true
    PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
}

