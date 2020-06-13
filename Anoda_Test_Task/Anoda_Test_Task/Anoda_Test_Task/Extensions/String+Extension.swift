//
//  String+Extension.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 10.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

extension String {
    static func getDiffTime(olderDate older: Date, newerDate newer: Date) -> (String?) {
        
        let formatter = DateComponentsFormatter()
        
        formatter.unitsStyle = .full
        var currentCalendar = Calendar.current
        
        currentCalendar.locale = .current
        currentCalendar.timeZone = .current
        formatter.calendar = currentCalendar
        
        let componentsLeftTime = formatter.calendar!.dateComponents([.year, .month, .day, .hour, .minute ], from: older, to: newer)
        let year = componentsLeftTime.year ?? 0
        if  year > 0 {
            let resultFormatingString = String.localizedStringWithFormat(NSLocalizedString("%u years ago", comment: ""), year)
            return resultFormatingString
        }
        let month = componentsLeftTime.month ?? 0
        if  month > 0 {
            let resultFormatingString = String.localizedStringWithFormat(NSLocalizedString("%u months ago", comment: ""), month)
            return resultFormatingString
        }
        
        let day = componentsLeftTime.day ?? 0
        if  day > 0 {
            let resultFormatingString = String.localizedStringWithFormat(NSLocalizedString("%u days ago", comment: ""), day)
            return resultFormatingString
        }
        let hour = componentsLeftTime.hour ?? 0
        if  hour > 0 {
            let resultFormatingString = String.localizedStringWithFormat(NSLocalizedString("%u hours ago", comment: ""), hour)
            return resultFormatingString
        }
        
        let minute = componentsLeftTime.minute ?? 0
        if  minute > 0 {
            let resultFormatingString = String.localizedStringWithFormat(NSLocalizedString("%u minutes ago", comment: ""), minute)
            return resultFormatingString
        }
        return nil
        
    }
    func indexDistance(of character: Character) -> Int? {
        guard let index = firstIndex(of: character) else { return nil }
        return distance(from: startIndex, to: index)
    }
}
