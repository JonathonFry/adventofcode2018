//
//  Day4.swift
//  adventofcode2018
//
//  Created by Jonathon Fry on 04/12/2018.
//  Copyright © 2018 Jonathon Fry. All rights reserved.
//

import Foundation

class Day4 {
    
    func part1() -> String {
        
        let data = FileUtils.loadFile(name: "day4")
        
        let array = FileUtils.split(data: data)
        let sorted = array.sorted(by: { return $0.compare($1) == .orderedAscending })
        
        var guardMap = [String:[Data]]()
        
        var asleepTime: String?
        
        var guardDate: Date?
        var guardID: String?
        var asleep = [String]()
        
        for item in sorted {
            let date = getDate(date: item.slice(from: "[", to: "]")!)
            if let guardId = item.slice(from: "#", to: " ") {
                // Write old data
                if guardID != nil {
                    var array = guardMap[guardID!] ?? []
                    array.append(Data(date: guardDate!, asleep: asleep))
                    guardMap[guardID!] = array
                }
                
                asleep = []
                asleepTime = nil
                guardID = guardId
                guardDate = date
            } else {
                if item.contains("falls") {
                    asleepTime = getTime(date: date)
                } else if item.contains("wakes")  {
                    let awakeTime = getTime(date: date)
                    
                    for i in Int(asleepTime!)!..<Int(awakeTime)! {
                        asleep.append(String(i))
                    }
                }
            }
        }
        
        if guardID != nil {
            var array = guardMap[guardID!] ?? []
            array.append(Data(date: guardDate!, asleep: asleep))
            guardMap[guardID!] = array
        }
        
        
        var highest = 0
        var sleepiestGuard = ""
        for (guardId, data) in guardMap {
            let count = data.reduce(0, { $0 + $1.asleep.count })
            if count > highest {
                highest = count
                sleepiestGuard = guardId
            }
        }
        
        let d = guardMap[sleepiestGuard]!
        var output = [String:Int]()
        for i in 0..<d.count-1 {
            let day = Set(d[i].asleep)
            let nextDay = Set(d[i+1].asleep)
            
            let common = day.intersection(nextDay)
            
            for minute in common {
                if let count = output[minute] {
                    output[minute] = (count + 1)
                } else {
                    output[minute] = 1
                }
            }
        }
        
        print(output)
        
        let h = Array(output).sorted(by: {$0.0 < $1.0}).first?.key
    

        let value = (Int(h!)! * Int(sleepiestGuard)!)
        
        return "Day 4 Part 1: \(value)"
    }
    
    func part2() -> String {
        return "Day 4 Part 2: "
    }
    
    private func getDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: date)
        return date!
    }
    
    private func getTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        return dateFormatter.string(from: date)
    }
    
    
    struct Data {
        var date: Date
        var asleep: [String]
    }
}
