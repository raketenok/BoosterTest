//
//  Date+Extensions.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 16.05.2020.
//

import Foundation


fileprivate let hourFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
}()


extension Date {
    
    func stringTime() -> String {
        return hourFormatter.string(from: self)
    }
    
    func isDescendingThan(_ otherDate: Date) -> Bool {
        let order = Calendar.current.compare(self, to: otherDate, toGranularity: .minute)
        return order == .orderedDescending
    }
    
    func minAlarmDate() -> Date {
        guard let date = Calendar.current.date(byAdding: .minute, value: 1, to: self) else { return self }
        return date
    }
    
}
