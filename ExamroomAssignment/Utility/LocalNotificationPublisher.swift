//
//  LocalNotificationPublisher.swift
//  ExamroomAssignment
//
//  Created by Capgemini on 25/02/21.
//

import Foundation
import UserNotifications
import UIKit

class LocalNotificationPublisher: NSObject {
    
    func sendNotification(title: String, subtitle: String, body: String, badge: Int?, delayInterval: Int?) {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.subtitle = subtitle
        notificationContent.body = body
        
        var delayTimeTrigger: UNTimeIntervalNotificationTrigger?
        
        if let delayInterval = delayInterval {
            delayTimeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(delayInterval), repeats: false)
        }
        
        if let badge = badge {
            var currentBadgeCount = UIApplication.shared.applicationIconBadgeNumber
            currentBadgeCount += badge
            notificationContent.badge = NSNumber(integerLiteral: currentBadgeCount)
        }
        
        notificationContent.sound = UNNotificationSound.default
       
        let request = UNNotificationRequest(identifier: "TestLocalNotification", content: notificationContent, trigger: delayTimeTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
}

