//
//  Day6.swift
//  adventofcode2018
//
//  Created by Jonathon Fry on 06/12/2018.
//  Copyright © 2018 Jonathon Fry. All rights reserved.
//

import Foundation

class Day6 {
    
    func part1() -> String {
        let data = FileUtils.loadFile(name: "day6")
        let array = FileUtils.split(data: data)
        
        let coords: [Pair<Int, Int>] =  array.map {
            
            let s = $0.split(separator: ",").map{ String($0).replacingOccurrences(of: " ", with: "") }
            
            return Pair(values:(Int(s[0])!, Int(s[1])!))
        }
        
        let maxX = coords.map{ $0.values.0 }.max()!
        let maxY = coords.map{ $0.values.1 }.max()!
        let minX = coords.map{ $0.values.0 }.min()!
        let minY = coords.map{ $0.values.1 }.min()!
        
        var board = [Pair<Int, Int>]()
        
        for i in minY...maxY {
            for j in minX...maxX {
                board.append(Pair(values: (j, i)))
            }
        }
        
        var distances = [Pair<Int, Int>: Pair<Pair<Int, Int> ,Int>]()
        
        for location in board {
            var lowestDistance = Int.max
            var lowestCoord = Pair(values: (0, 0))
            for coord in coords {
                let distance = taxicabDistance(start: coord, end: location)
                
                
                if distance < lowestDistance {
                  lowestDistance = distance
                    lowestCoord = coord
                } else if distance == lowestDistance {
                    lowestCoord = Pair(values: (0, 0))
                }
            }
            distances[location] = Pair(values:  (lowestCoord, lowestDistance))
        }
        
        
        var sum = [Pair<Int,Int> : Int]()
        for (_, value) in distances {
            let a = value.values.0
            var count = sum[a] ?? 0
            count += 1
            sum[a] = count
        }
        
        let solution = sum.values.max()!
    
        return "Day 6 part 1: \(solution)"
    }
    
    func part2() -> String {
        let data = FileUtils.loadFile(name: "day6")
        let array = FileUtils.split(data: data)
        
        let coords: [Pair<Int, Int>] =  array.map {
            
            let s = $0.split(separator: ",").map{ String($0).replacingOccurrences(of: " ", with: "") }
            
            return Pair(values:(Int(s[0])!, Int(s[1])!))
        }
        
        let maxX = coords.map{ $0.values.0 }.max()!
        let maxY = coords.map{ $0.values.1 }.max()!
        let minX = coords.map{ $0.values.0 }.min()!
        let minY = coords.map{ $0.values.1 }.min()!
        
        var board = [Pair<Int, Int>]()
        
        for i in minY...maxY {
            for j in minX...maxX {
                board.append(Pair(values: (j, i)))
            }
        }
        
        
        var safeRegion = [Pair<Int, Int>]()
        
        for location in board {
            var distances = Array<Int>()
            
            for coord in coords {
                let distance = taxicabDistance(start: coord, end: location)
                
                distances.append(distance)
            }
            
            if distances.reduce(0, +) < 10000 {
                safeRegion.append(location)
            }
        
        }
        
        let solution = safeRegion.count
        
        return "Day 6 part 2: \(solution)"
    }
    
    func taxicabDistance(start: Pair<Int, Int>, end: Pair<Int, Int>) -> Int {
        return abs(end.values.0 - start.values.0) + abs(end.values.1 - start.values.1)
    }
}
