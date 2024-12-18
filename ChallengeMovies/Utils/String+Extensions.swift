//
//  String+Extensions.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 3/12/24.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        if let path = Bundle.main.path(forResource: LocalizationManager.shared.currentLanguage, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(self, bundle: bundle, comment: "")
        }
        fatalError("Not lenguages supported")
    }
}
