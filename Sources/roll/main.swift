//
//  roll
//  main.swift
//  
//
//  Created by Brad Siegfreid on 8/16/20.
//

import Dice
import ArgumentParser

struct Roll: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "A dice roll simulator.")

    @Argument(help: "Input in 3d6 style dice notation or a range like 1-100")
    var input: String
    
    mutating func run() throws {
        print(try Dice.roll(input))
    }
}

Roll.main()
