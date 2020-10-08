//
//  GameData.swift
//  SFMemory
//
//  Created by Vincent Caronnet on 04/10/2020.
//

import SwiftUI
import Combine

final class GameData: ObservableObject {
    @AppStorage("bestScore") var bestScore: Int = 0
    
//    @Published var symbols: [String] = []
    @Published var shownCards: [Int] = []
    @Published var matchedCards: [String] = []
    @Published var score = 0
    @Published var victory = false

    @Published var scoreColor = Color.blue

//    func resetSymbols() {
//        let selectedSymbols = allSymbols.shuffled().prefix(14)
//        symbols = (selectedSymbols + selectedSymbols).shuffled()
//    }
}

enum ScoreColor {
    case lowerThanBestScore(Color)
    case equalThanBestScore(Color)
    case greaterThanBestScore(Color)
}
