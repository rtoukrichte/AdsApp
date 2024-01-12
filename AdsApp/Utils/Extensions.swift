//
//  Extensions.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 12/01/2024.
//

import Foundation


extension String {
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let strDate = dateFormatter.date(from: self)
        return strDate ?? Date()
    }
}

extension Date {
    func createformattedDate(with customFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = customFormat
        return dateFormatter.string(from: self)
    }
}
