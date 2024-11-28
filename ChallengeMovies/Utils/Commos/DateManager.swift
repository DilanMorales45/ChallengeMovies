//
//  DateManager.swift
//  DemoUI
//
//  Created by Angel Kenyi Rodriguez Vergara on 26/11/24.
//

import Foundation

extension String {
    func toDateWithFormat(_ format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}

extension Date {
    func toStringWithFormat(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "es_PE")
        return dateFormatter.string(from: self)
    }
}
