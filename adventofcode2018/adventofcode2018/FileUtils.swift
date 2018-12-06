//
//  FileUtils.swift
//  adventofcode2018
//
//  Created by Jonathon Fry on 02/12/2018.
//  Copyright © 2018 Jonathon Fry. All rights reserved.
//

import Foundation

class FileUtils {
    static func loadFile(name: String) -> String {
        if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
                return ""
            }
        } else {
            return ""
        }
    }
    
    static func split(data: String) -> [String] {
        return data.components(separatedBy: CharacterSet.newlines).filter{$0 != ""}
    }
    
}

extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
}

struct Pair<T:Hashable,U:Hashable> : Hashable, CustomStringConvertible {
    let values : (T, U)
    
    var description: String {
        let (a,b) = values
        return "(\(a), \(b))"
    }
    
    var hashValue : Int {
        get {
            let (a,b) = values
            return a.hashValue &* 31 &+ b.hashValue
        }
    }
    
    // comparison function for conforming to Equatable protocol
    static func ==<T:Hashable,U:Hashable>(lhs: Pair<T,U>, rhs: Pair<T,U>) -> Bool {
        return lhs.values == rhs.values
    }
}

