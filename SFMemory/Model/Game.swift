//
//  Model.swift
//  SFMemory
//
//  Created by Vincent Caronnet on 03/10/2020.
//

import Foundation
import SwiftUI

class Game {
    @EnvironmentObject var gameData: GameData

    private var shownCards: [Int] = []
    private var matchedCards: [String] = []
    private var attempts = 0

    static let shared = Game()

    private let selectedSymbols = allSymbols.shuffled().prefix(14)

    var symbols: [String]
    private init() {
        symbols = (selectedSymbols + selectedSymbols).shuffled()
    }
    
    private func setSymbols() {
        symbols = (selectedSymbols + selectedSymbols).shuffled()
    }
}

