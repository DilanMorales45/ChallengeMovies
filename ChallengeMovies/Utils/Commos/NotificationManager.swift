//
//  NotificationManager.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 6/12/24.
//

import Foundation

class NotificationManager {
    private static let notificationName = Notification.Name("languageDidChange")
    
     class func addObserver(selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notificationName, object: nil)
    }

    class func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
    }
}
