//
//  File.swift
//  
//
//  Created by Brad Siegfreid on 8/16/20.
//

import Dice
import ArgumentParser

struct RollOptions: ParsableArguments {
    @Option(help: ArgumentHelp("Rolls the dice <n> times.", valueName: "n"))
    var times = 1

    @Option(help: ArgumentHelp(
        "Rolls an <m>-sided dice.",
        discussion: "Use this option to override the default value of a six-sided die.",
        valueName: "m"))
    var sides = 6
}

// If you prefer writing in a "script" style, you can call `parseOrExit()` to
// parse a single `ParsableArguments` type from command-line arguments.
let options = RollOptions.parseOrExit()

let result = Dice.roll(options.times, d:options.sides)

print("Test: \(result)")
