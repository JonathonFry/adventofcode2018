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

        // Do any additional setup after loading the view.
        
        let day1 = Day1()
        let part1 = day1.part1()
        let part2 = day1.part2()
        label.stringValue = "\(part1)\n\(part2)"
    }
}

