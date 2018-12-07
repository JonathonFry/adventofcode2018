//
// Created by Jonathon Fry on 2018-12-07.
// Copyright (c) 2018 Jonathon Fry. All rights reserved.
//

import Foundation

class Day7 {

    /*
    Step {
    key
    children [Step]
   }

   [C] -> A, F
   [A] -> B, D
   [B] -> E
   [D] -> E
   [F] -> E

   Step 1. Find root node (has no before step X)
   Step 2. Starting at root node, find children
   Step 3. Calculate what step to process next


   calculate steps that are available to be run e.g. [A] [F]

   from available steps, choose one and run it [A]
   update available steps
   sort alphabetically

   maintain a history of completed steps
   to check if step is available see if its conditions have been met (aka parent is in completed)


   [B] [D] [F]

    RUN

   [C]

   [A] [F] -> [A]

   [F] [B] [D] -> [B]

   [F] [D] -> [D]

   [F] -> [F]

   [E] -> [E]

   Step 1. Calculate tree
   Find root node
   find children of node


    calculating available steps
    - if root add sub steps to available
    of available steps order by alphabetically

    while available steps has items
    {
        order alphabetically
        select first step to 'evaluate'
        evaluating = adding step to completed
        for each child of step check if it is available (has all dependent parents in complete)
        add to available if so

    }

    available steps
    completed steps


    output = completed steps to string


    */

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

        print("steps: \(steps)")


        // Find root
        var keys: Set<String> = Set(steps.compactMap {
            $0.0
        })
        let children: Set<String> = Set(steps.flatMap {
            $0.1
        })

        print("keys: \(keys)")
        print("children: \(children)")

        keys.subtract(children)
        print("root keys: \(keys)")
        let root = keys.first!

        print("root: \(root)")

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

        print("history: \(history.joined())")


        return "Day 7 Part 1: "
    }

    func part2() -> String {
        return "Day 7 Part 2: "
    }

}