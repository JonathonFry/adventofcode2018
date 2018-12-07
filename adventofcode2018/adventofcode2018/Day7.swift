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


        /*
        Define a list of workers
        worker works on a step
        duration of work is  60 + (if a = 1)

        */

        var workers = [Worker(), Worker(), Worker(), Worker(), Worker()]

        var availableSteps = [String]()
        var history = [String]()

        availableSteps.append(contentsOf: keys)

        var duration = 0

        while availableSteps.count > 0 || isWorking(workers: &workers) {
            availableSteps = availableSteps.sorted {
                $0 < $1
            }

            // if have available work, allocate
            // iterate through workers and do work (count down duration)
            // if any workers hit = mark as complete and add to history

            for var worker in workers {
                if worker.calculating() {
                    worker.work()
                    if worker.duration == 0 {
                        let step = worker.key!
                        worker.finish()

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
                }
            }

            //TODO - mutability, not updating the correct workers

            for (i, step) in availableSteps.enumerated() {

                if var worker = free(workers: &workers) {
                    worker.key = step
                    worker.duration = stepDuration(letter: step)
                    availableSteps.remove(at: i)
                } else {
                    break
                }
            }

            print("\(availableSteps.count) \(isWorking(workers: &workers))")

            duration += 1
        }

        return "Day 7 Part 2: \(duration)"
    }

    func stepDuration(letter: String) -> Int {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return 60 + (alphabet.firstIndex(of: Character(letter))!.encodedOffset) + 1
    }

    func free(workers: inout [Worker]) -> Worker? {
        return workers.first(where: { !$0.calculating() })
    }

    func isWorking(workers: inout[Worker]) -> Bool {
        for worker in workers {
            if worker.calculating() {
                print("worker is working: \(worker.key)")
                return true
            }
        }
        return false
    }

    struct Worker {
        var key: String?
        var duration: Int = 0

        init(key: String? = nil,
             duration: Int = 0) {
            self.key = key
            self.duration = duration
        }

        mutating func finish() {
            self.key = nil
            self.duration = 0
        }

        mutating func work() {
            self.duration -= 1
        }

        func calculating() -> Bool {
            return duration > 0
        }

    }

}