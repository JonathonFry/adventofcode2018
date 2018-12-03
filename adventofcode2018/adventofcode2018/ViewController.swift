//
//  ViewController.swift
//  adventofcode2018
//
//  Created by Jonathon Fry on 02/12/2018.
//  Copyright © 2018 Jonathon Fry. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var label: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var output : [String] = []
        
        let day1 = Day1()
        output.append(day1.part1())
        output.append(day1.part2())
        let day2 = Day2()
        output.append(day2.part1())
        output.append(day2.part2())
        
        label.stringValue = "\(output.joined(separator: "\n"))"
    }
}

