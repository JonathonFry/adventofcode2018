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
    
}
