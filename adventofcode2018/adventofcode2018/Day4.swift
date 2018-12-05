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
        
        var guardMap = [String:[[Int]]]() // guardId:[ [minute, minute]]
        
        var asleepAt: Int?
        
        var currentGuardId: String?
        var asleep = [Int]()
        
        // Write guard data
        for item in sorted {
            let dateString = item.slice(from: "[", to: "]")
            let minute = getMinute(date: dateString!)
            let guardId = item.slice(from: "#", to: " ")
            
            if guardId != nil {
                if currentGuardId != nil {
                    var array = guardMap[currentGuardId!] ?? []
                    array.append(asleep)
                    guardMap[currentGuardId!] = array
                }
                
                currentGuardId = guardId
                asleep = []
                asleepAt = nil
            }
            
            if item.contains("falls") {
                asleepAt = minute
                
            }
            
            if item.contains("wakes") {
                let awakeAt = minute
                for i in asleepAt!..<awakeAt {
                    asleep.append(i)
                }
                asleepAt = nil
            }
            
        }
        
        // Write final data
        if currentGuardId != nil {
            var array = guardMap[currentGuardId!] ?? []
            array.append(asleep)
            guardMap[currentGuardId!] = array
        }
        
        
        // Find guard with most minutes asleep
        var highest = 0
        var sleepyGuard = ""
        for (guardId, asleep) in guardMap {
            var total = 0
            for naps in asleep {
                total += naps.count
            }
            if total > highest {
                highest = total
                sleepyGuard = guardId
            }
        }
        
        // Find most common minute asleep
        var minutes = [Int:Int]()
        
        for sleeps in guardMap[sleepyGuard]! {
            for minute in sleeps {
                var count = minutes[minute] ?? 0
                count += 1
                minutes[minute] = count
            }
        }
        
        var maxMinute = 0
        var maxCount = 0
        for (minute, count) in minutes {
            if count > maxCount {
                maxCount = count
                maxMinute = minute
            }
        }
        let output = maxMinute * Int(sleepyGuard)!
        
        return "Day 4 Part 1: \(output)"
    }
    
    func part2() -> String {
        let data = FileUtils.loadFile(name: "day4")
        
        let array = FileUtils.split(data: data)
        let sorted = array.sorted(by: { return $0.compare($1) == .orderedAscending })
        
        var guardMap = [String:[[Int]]]() // guardId:[ [minute, minute]]
        
        var asleepAt: Int?
        
        var currentGuardId: String?
        var asleep = [Int]()
        
        // Write guard data
        for item in sorted {
            let dateString = item.slice(from: "[", to: "]")
            let minute = getMinute(date: dateString!)
            let guardId = item.slice(from: "#", to: " ")
            
            if guardId != nil {
                if currentGuardId != nil {
                    var array = guardMap[currentGuardId!] ?? []
                    array.append(asleep)
                    guardMap[currentGuardId!] = array
                }
                
                currentGuardId = guardId
                asleep = []
                asleepAt = nil
            }
            
            if item.contains("falls") {
                asleepAt = minute
                
            }
            
            if item.contains("wakes") {
                let awakeAt = minute
                for i in asleepAt!..<awakeAt {
                    asleep.append(i)
                }
                asleepAt = nil
            }
            
        }
        
        // Write final data
        if currentGuardId != nil {
            var array = guardMap[currentGuardId!] ?? []
            array.append(asleep)
            guardMap[currentGuardId!] = array
        }
        
        // Find most common minute asleep
        var guardMinutes = [String : [Int:Int]]()
        
        // For each guard count the minute asleep
        for (guardId, sleeps) in guardMap {
            var minutes = guardMinutes[guardId] ?? [Int:Int]()
            
            for sleep in sleeps {
                for minute in sleep {
                    var count = minutes[minute] ?? 0
                    count += 1
                    minutes[minute] = count
                }
            }
            guardMinutes[guardId] = minutes
        }
        
        var highestGuardId = ""
        var highestMinute = 0
        var highestCount = 0
        for (guardId, minutesCount) in guardMinutes {
            for (minute, count) in minutesCount {
                if count > highestCount {
                    highestCount = count
                    highestMinute = minute
                    highestGuardId = guardId
                }
            }
        }

        let output = Int(highestGuardId)! * highestMinute
        
        return "Day 4 Part 2: \(output)"
    }
    
    private func getMinute(date: String) -> Int {
        let split = date.split(separator: ":")
        return Int(split[1])!
    }

}
