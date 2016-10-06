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
        
        let monthFlags = NSCalendar.Unit.month
        let dayFlags = NSCalendar.Unit.day
        let hourFlags = NSCalendar.Unit.hour
        let minuteFlags = NSCalendar.Unit.minute
        let secFlags = NSCalendar.Unit.second
        let monthComponents = calendar.components(monthFlags, from: date1, to: date2, options: []).month!
        let dayComponents = calendar.components(dayFlags, from: date1, to: date2, options: []).day!
        let hourComponents = calendar.components(hourFlags, from: date1, to: date2, options: []).hour!
        let minuteComponents = calendar.components(minuteFlags, from: date1, to: date2, options: []).minute!
        let secComponents = calendar.components(secFlags, from: date1, to: date2, options: []).second!

        
        let timeSpent =
        String(describing: monthComponents) + "M " +
        String(describing: dayComponents) + "d " +
        String(describing: hourComponents) + "h " +
        String(describing: minuteComponents) + "m " +
        String(describing: secComponents) + "sec "
        
        return timeSpent
    }
}

