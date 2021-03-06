//
//  ext+Dates.swift
//  GitHubProject
//
//  Created by Tee Becker on 10/21/20.
//

import UIKit

//1. determine the date format that we want. Ext of Date
extension Date {
    func convertToMonthYearFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}

// using the below in NetworkManager.swift file to convert to Date format.
// let decoder = JSONDecoder()
// decoder.dateDecodingStrategy = .iso8601

////2. convert date to original string so xcode knows what it means.
//extension String{
//    func convertToDate() -> Date?{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.timeZone = .current
//
//        return dateFormatter.date(from: self)
//    }
//
////3. convert date to readable String using the two extensions above
//    func convertToDisplayFormat() -> String{
//        guard let date = self.convertToDate() else {return "n/a"}
//        return date.convertToMonthYearFormat()
//    }
//}



