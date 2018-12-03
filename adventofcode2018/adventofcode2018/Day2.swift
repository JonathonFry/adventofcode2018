//
//  Day2.swift
//  adventofcode2018
//
//  Created by Jonathon Fry on 02/12/2018.
//  Copyright © 2018 Jonathon Fry. All rights reserved.
//

import Foundation

class Day2 {
    
    func part1() -> String {
        let day2 = FileUtils.loadFile(name: "day2")
        
        let array = FileUtils.split(data: day2)
        
        var two = 0
        var three = 0
        
        for item in array {
            var map = [Character: Int]()
            for c in item {
                if map[c] == nil {
                    map[c] = item.filter {$0 == c}.count
                }
            }
            
            var countedTwo = false
            var countedThree = false
            for (_, count) in map {
                if count == 2 && !countedTwo {
                    two += 1
                    countedTwo = true
                }  else if count == 3  && !countedThree {
                    three += 1
                    countedThree = true
                }
            }
        }
        
        let checksum = two * three
        
        return "Day 2 Part 1: \(checksum)"
    }
    
    func part2() -> String {
        let day2 = FileUtils.loadFile(name: "day2")
        
        let array = FileUtils.split(data: day2)
        
        var output = ""
        
        for i in 0..<array.count {
            let item = array[i]
            for j in 0..<array.count {
                let nextItem = array[j]
                
                var position = 0
                var difference = 0
                for z in 0..<item.count {
                    if item[z] != nextItem[z] {
                        difference += 1
                        position = z
                    }
                }
                
                if difference == 1 {
                    output = item
                    output.remove(at: String.Index(encodedOffset: position))
                }
                
            }
        }
        
        return "Day 2 Part 2: \(output)"
    }
}
