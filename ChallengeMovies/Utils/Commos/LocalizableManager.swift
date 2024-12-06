//
//  LocalizationManager.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 30/11/24.
//

import Foundation

class LocalizationManager {
    static var shared = LocalizationManager()
    
    private let LocalizeUserDefaultKey = "LocalizeUserDefaultKey"
    
    var currentLanguage: String {
        if let savedLanguage = UserDefaults.standard.string(forKey: LocalizeUserDefaultKey) {
            return savedLanguage
        }
        
        let systemLanguage = SupportedLenguages(rawValue: Locale.current.language.languageCode?.identifier ?? "")
        return systemLanguage.rawValue
    }
    
    private init(){
        
    }

    func set(language: SupportedLenguages){
        UserDefaults.standard.setValue(language.rawValue, forKey: LocalizeUserDefaultKey)
    }
}


extension LocalizationManager {
    enum SupportedLenguages: String {
        case en
        case es
        
        init(rawValue: String) {
            if rawValue == SupportedLenguages.en.rawValue {
                self = .en
            } else if rawValue == SupportedLenguages.es.rawValue {
                self = .es
            } else {
                self = .en
            }
        }
    }
}
