//
//  File.swift
//  adventofcode2018
//
//  Created by Jonathon Fry on 03/12/2018.
//  Copyright © 2018 Jonathon Fry. All rights reserved.
//

import Foundation

class Day3 {
    func part1() -> String {
        let data = FileUtils.loadFile(name: "day3")
        
        let array = FileUtils.split(data: data)
        
        var map = [Pair<Int,Int>: Int]()
        
        for item in array {
            let stripped = item.replacingOccurrences(of: " @", with: "").replacingOccurrences(of: ":", with: "")
            let s = stripped.components(separatedBy: " ")
            let coords = s[1]
            let size = s[2]
            let xy = coords.components(separatedBy: ",")
            let x = Int(xy[0])!
            let y = Int(xy[1])!
            
            let wh = size.components(separatedBy: "x")
            let w = Int(wh[0])!
            let h = Int(wh[1])!
            
            for i in 0..<h {
                for j in 0..<w {
                    let newX = x+j
                    let newY = y+i
                    let pair = Pair(values: (newX, newY))
                    let value = map[pair]
                    map[pair] = (value ?? 0) + 1
                }
            }
        }
        
        var count = 0
        for (_, value) in map {
            if value >= 2 {
                count += 1
            }
        }
        
        return "Day 3 Part 1: \(count)"
    }
    func part2() -> String {
        let data = FileUtils.loadFile(name: "day3")
        
        let array = FileUtils.split(data: data)
        
        var map = [Pair<Int,Int>: Int]()
        
        var ids = [String: Array<Pair<Int,Int>>]()
        
        for item in array {
            let stripped = item.replacingOccurrences(of: " @", with: "").replacingOccurrences(of: ":", with: "")
            let s = stripped.components(separatedBy: " ")
            let id = s[0]
            let coords = s[1]
            let size = s[2]
            let xy = coords.components(separatedBy: ",")
            let x = Int(xy[0])!
            let y = Int(xy[1])!
            
            let wh = size.components(separatedBy: "x")
            let w = Int(wh[0])!
            let h = Int(wh[1])!
            
            for i in 0..<h {
                for j in 0..<w {
                    let newX = x+j
                    let newY = y+i
                    let pair = Pair(values: (newX, newY))
                    let value = map[pair]
                    map[pair] = (value ?? 0) + 1
                    
                    
                    var history = ids[id] ?? Array<Pair<Int,Int>>()
                    history.append(pair)
                    ids[id] = history
                }
            }
        }
        
        var finalId = ""
        for (id, values) in ids {
            
            
            outer: for i in 0..<values.count{
                if map[values[i]]! > 1 {
                    break
                } else if i == (values.count - 1) {
                    finalId = id
                    break outer
                }
            }
            
            /*
             Check whether count of all coords for ID count == 1
             */
            
            
        }
        
        return "Day 3 Part 2: \(finalId)"
    }
}
