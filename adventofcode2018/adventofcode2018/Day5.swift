//
//  Day5.swift
//  adventofcode2018
//
//  Created by Jonathon Fry on 05/12/2018.
//  Copyright © 2018 Jonathon Fry. All rights reserved.
//

import Foundation


class Day5 {
    
    func part1() -> String {
        let data = FileUtils.loadFile(name: "day5")
        let filtered = String(data.filter { !" \n\t\r".contains($0) })
        var processed = ""
        let solution = solve(processed: &processed, input: filtered)
        print("Day 5 part 1: \(solution.count)")
        
        return "Day 5 part 1: \(solution.count)"
    }
    
    func solve(processed: inout String, input: String) -> String {
        print("solving processed: \(processed.count), input: \(input.count)")
        var output = input
        var safe = 0
        for i in 0..<input.count-1 {
            let a = input[i]
            let b = input[i+1]
            if a.lowercased() == b.lowercased() && ((isLowercase(input: a) && isUppercase(input: b)) || (isLowercase(input: b) && isUppercase(input: a))) {
                safe = i - 1
                output = removeCharacterAt(input: output, index: i)
                output = removeCharacterAt(input: output, index: i)
               break
            }
        }
        
        if output != input {
            if safe > 0 {
                // split string
                let newProcessed = output.substring(toIndex: safe)
                processed = processed + newProcessed
                
                //TODO - correctly substring by range
                output = output.substring(fromIndex: safe)
            }
            return solve(processed: &processed, input: output)
        } else {
            return processed + input
        }
    }
    
    func isLowercase(input: String) -> Bool {
        return CharacterSet.lowercaseLetters.contains(input.unicodeScalars.first!)
    }
    
    func isUppercase(input: String) -> Bool {
        return CharacterSet.uppercaseLetters.contains(input.unicodeScalars.first!)
    }
    
    func removeCharacterAt(input: String, index: Int) -> String {
        var output = input
        let index = input.index(input.startIndex, offsetBy: index, limitedBy: input.endIndex)
        output.remove(at: index!)
        return output
    }
    
    func part2() -> String {
        return "Day 5 part 2: "
    }
}
