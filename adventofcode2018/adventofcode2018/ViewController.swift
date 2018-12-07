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
    @IBOutlet weak var time: NSTextField!
    
    @IBOutlet weak var loading: NSProgressIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .background).async {
            var output : [String] = []
            let startTime = CFAbsoluteTimeGetCurrent()
            
//            let day1 = Day1()
//            output.append(day1.part1())
//            output.append(day1.part2())
//
//            let day2 = Day2()
//            output.append(day2.part1())
//            output.append(day2.part2())
//
//            let day3 = Day3()
//            output.append(day3.part1())
//            output.append(day3.part2())
//
//            let day4 = Day4()
//            output.append(day4.part1())
//            output.append(day4.part2())
//
//            let day5 = Day5()
//            output.append(day5.part1())
//            output.append(day5.part2())
//
//            let day6 = Day6()
//            output.append(day6.part1())
//            output.append(day6.part2())

            let day7 = Day7()
            output.append(day7.part1())
            output.append(day7.part2())
            
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            
            DispatchQueue.main.async {
                self.loading.isHidden = true
                self.label.stringValue = "\(output.joined(separator: "\n"))"
                self.time.stringValue = "\(Double(timeElapsed))s"
            }
        }
        
    }
}

