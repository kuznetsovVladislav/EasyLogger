//
//  Date.swift
//  EasyLogging
//
//  Created by Владислав  on 07.10.16.
//  Copyright © 2016 Zazmic. All rights reserved.
//

import Foundation

extension Date {

    static func timeSpent(fromDate firstDate: Date, toDate secondDate: Date) -> String {
        
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        
        let date1 = firstDate
        let date2 = secondDate

        let secFlags = NSCalendar.Unit.second
        let secComponents = calendar.components(secFlags, from: date1, to: date2, options: []).second!

        let secondsSpent = secComponents  % 60
        let minutesSpent = Int(secComponents  / 60)
        let hoursSpent = Int(minutesSpent / 60)
        
        var timeSpent = ""
        
        if hoursSpent > 0 {
            timeSpent =
                String(describing: hoursSpent) + "h " +
                String(describing: minutesSpent) + "m " +
                String(describing: secondsSpent) + "s "
        } else if minutesSpent > 0 {
            timeSpent =
                String(describing: minutesSpent) + "m " +
                String(describing: secondsSpent) + "s "
        } else {
            timeSpent = String(describing: secondsSpent) + "s "
        }
        
        return timeSpent
    }
    
    static func readableDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

