//
//  ViewController.swift
//  SendNotification
//
//  Created by Yusuf Turan on 17.09.2021.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
  
  var permissionControl = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //show notification when app is active.
    UNUserNotificationCenter.current().delegate = self
    
    // Request a permission control for user. Its sends notification when app is passive state.
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, err) in
      self.permissionControl = granted
      if granted {
        print("Permission success.")
      } else {
        print("Permission failed.")
      }
    }
  }
  
  @IBAction func sendNotification(_ sender: Any) {
    if permissionControl {
      
      let okButton = UNNotificationAction(identifier: "okButton", title: "YES", options: .foreground)
      let denyButton = UNNotificationAction(identifier: "denyButton", title: "No", options: .foreground)
      let deleteButton = UNNotificationAction(identifier: "deleteButton", title: "Delete", options: .destructive)
      
      let categories = UNNotificationCategory(
        identifier: "categories",
        actions: [okButton, denyButton, deleteButton],
        intentIdentifiers: [],
        options: []
      )
      
      UNUserNotificationCenter.current().setNotificationCategories([categories])
      
      let message = UNMutableNotificationContent()
      message.title = "Hello Man"
      message.subtitle = "This is subtitle"
      message.body = "5 > 4 mü ?"
      message.badge = 1 //badge count
      message.sound = UNNotificationSound.default
      message.categoryIdentifier = "categories"
      
//      Trigger with specific date:
//      var date = DateComponents()
//      date.minute = 30
//      date.hour = 8
//      date.day = 20
//      date.month = 4
//      let triggerWithDate = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
      
      let notificationRequest = UNNotificationRequest(identifier: "NotificationSender", content: message, trigger: trigger)
      
      UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
    }
  }
}

//extension for shows notification when app is active
extension ViewController: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound, .badge])
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    if response.actionIdentifier == "okButton" {
      print("True response")
    } else if response.actionIdentifier == "denyButton" {
      print("False response")
    } else if response.actionIdentifier == "deleteButton" {
      print("Deleted")
    }
  }
}

