//
//  LocalizationManager.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 30/11/24.
//

import Foundation

class LocalizationManager {
    static var currentLanguage: String {
        get {
            if let savedLanguage = UserDefaults.standard.string(forKey: LocalizeUserDefaultKey) {
                           return savedLanguage
                       }
            return Locale.current.language.languageCode?.identifier ?? "en"
//            return UserDefaults.standard.string(forKey: LocalizeUserDefaultKey) ?? "es-419"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: LocalizeUserDefaultKey)
        }
    }
    
    static func translate(_ key: String) -> String {
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(key, bundle: bundle, comment: "")
        }
        return key
    }
}
