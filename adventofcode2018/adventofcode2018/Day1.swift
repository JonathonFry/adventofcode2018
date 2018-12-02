//
//  Day1.swift
//  adventofcode2018
//
//  Created by Jonathon Fry on 02/12/2018.
//  Copyright © 2018 Jonathon Fry. All rights reserved.
//

import Foundation

class Day1 {
    
    func part1() -> String {
        let day1 = FileUtils.loadFile(name: "day1")
        var total = 0
        
        let array = day1.components(separatedBy: CharacterSet.newlines).filter{$0 != ""}
        
        for item in array {
            let op = item.prefix(1)
            let start = String.Index(encodedOffset: 1)
            let value = Int(String(item[start..<item.endIndex]))
            
            switch(op) {
            case "+":
                total += value!
            case "-":
                total -= value!
            default:
                print("do nothing")
            }
        }
        
        
        return "Day 1 Part 1: \(total)"
    }
    
    func part2() -> String {
        let day1 = FileUtils.loadFile(name: "day1")
        let array = day1.components(separatedBy: CharacterSet.newlines).filter{$0 != ""}
        
        var total = 0
        var history : Set = [0]
        
        var i = 0
        var found = false
        while (!found) {
            let line = array[i % array.count]
            
            let op = line.prefix(1)
            let start = String.Index(encodedOffset: 1)
            let value = Int(String(line[start..<line.endIndex]))
            
            switch(op) {
            case "+":
                total += value!
            case "-":
                total -= value!
            default:
                print("do nothing")
            }
            
            if history.contains(total) {
                found = true
            } else {
                history.insert(total)
            }
            
            i += 1
        }
        
        return "Day 1 Part 2: \(total)"
    }
    
    
}
