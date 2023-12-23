//
//  String+Extensions.swift
//  RickAndMortyApp
//
//  Created by Murat on 23.12.2023.
//

import Foundation

extension String {
    
    func convertToDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String{
        guard let date = self.convertToDate() else {return "N/A"}
        return date.converToMonthDayYearFormat()
    }
    
}
