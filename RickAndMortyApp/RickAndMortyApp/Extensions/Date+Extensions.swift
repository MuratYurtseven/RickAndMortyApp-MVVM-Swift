//
//  Date+Extensions.swift
//  RickAndMortyApp
//
//  Created by Murat on 23.12.2023.
//

import Foundation

extension Date{
    
    func converToMonthDayYearFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
        
    }
    
}
