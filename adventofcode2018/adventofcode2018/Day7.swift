//
// Created by Jonathon Fry on 2018-12-07.
// Copyright (c) 2018 Jonathon Fry. All rights reserved.
//

import Foundation

class Day7 {

    func part1() -> String {
        let data = FileUtils.loadFile(name: "day7")
        let array = FileUtils.split(data: data)

        // Create tree
        var steps = [String: [String]]()

        for item in array {
            let split = item.split(separator: " ")
            let key = String(split[1])
            let child = String(split[7])

            var children = steps[key] ?? [String]()
            children.append(child)
            steps[key] = children
        }

        // Find root
        var keys: Set<String> = Set(steps.compactMap {
            $0.0
        })
        let children: Set<String> = Set(steps.flatMap {
            $0.1
        })

        keys.subtract(children)

        var availableSteps = [String]()
        var history = [String]()

        availableSteps.append(contentsOf: keys)

        while availableSteps.count > 0 {
            availableSteps = availableSteps.sorted {
                $0 < $1
            }

            let step = availableSteps.removeFirst()
            history.append(step)

            if let children = steps[step] {

                for child in children {
                    var parents = Set<String>()

                    for step in steps {
                        if step.value.contains(child) {
                            parents.insert(step.key)
                        }
                    }

                    if parents.isSubset(of: Set(history)) {
                        availableSteps.append(child)
                    }

                }

            }

        }

        return "Day 7 Part 1: \(history.joined())"
    }

    func part2() -> String {
        return "Day 7 Part 2: "
    }

}