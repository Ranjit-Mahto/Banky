//
//  Date+Utils.swift
//  Bankey
//
//  Created by Ranjit Mahto on 17/09/23.
//

import Foundation

extension Date {
    
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation:"IST")
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
    
}
