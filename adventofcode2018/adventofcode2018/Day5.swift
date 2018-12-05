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
        let solution = solve(input: Array(filtered).map({ String($0) }))
        
        return "Day 5 part 1: \(solution.count)"
    }
    
    
    func solve(input: [String]) -> String {
        var output = input
        var calculating = true
        var safe = 0
        while(calculating) {
            for i in safe..<output.count {
                if i < output.count - 1 {
                    let a = output[i]
                    let b = output[i+1]
                    
                    if a.lowercased() == b.lowercased() && ((isLowercase(input: a) && isUppercase(input: b)) || (isLowercase(input: b) && isUppercase(input: a))) {
                        output.removeSubrange(i..<i+2)
                        if i - 1 > 0 {
                            safe = i - 1
                        }
                        break
                    }
                }
                
                if i == output.count - 1 {
                    calculating = false
                }
            }
        }
        return output.joined()
    }
    
    
    func isLowercase(input: String) -> Bool {
        return CharacterSet.lowercaseLetters.contains(input.unicodeScalars.first!)
    }
    
    func isUppercase(input: String) -> Bool {
        return CharacterSet.uppercaseLetters.contains(input.unicodeScalars.first!)
    }
    
    func part2() -> String {
        let data = FileUtils.loadFile(name: "day5")
        let filtered = String(data.filter { !" \n\t\r".contains($0) })
        let array = Array(filtered).map{ String($0) }
        
        let unique = Array(Set(array.map{ $0.uppercased() }))
        
        var solutions = [Int]()
        for letter in unique {
            let input = Array(array).filter{ $0 != letter && $0 != letter.lowercased()}
            let solution = solve(input: input)
            solutions.append(solution.count)
        }
        
        return "Day 5 part 2: \(solutions.min()!)"
    }
}
