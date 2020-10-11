//
//  GameData.swift
//  SFMemory
//
//  Created by Vincent Caronnet on 04/10/2020.
//

import SwiftUI
import Combine

final class GameData: ObservableObject {
    let maxScore = 999

    enum alertType {
        case victory, maxScore
    }

    @AppStorage("bestScore") var bestScore: Int = 0

    @Published var rootIsActive = false

    @Published var symbols: [String] = []
    @Published var shownCards: [Int] = []
    @Published var matchedCards: [String] = []
    @Published var score = 0 {
        didSet {
            if score == 0 || score == bestScore {
                scoreColor = .blue
            }
            if (score != 0 && score < bestScore) || bestScore == 0 {
                scoreColor = .green
            }
            if (score > bestScore) && bestScore > 0 {
                scoreColor = .orange
            }
        }
    }

    @Published var activeAlert = alertType.victory

    @Published var victory = false {
        didSet {
            if victory {
                activeAlert = .victory
                showAlert = true
            }
        }
    }
    @Published var showAlert = false

    @Published var scoreColor = Color.blue

    init() {
        setSymbols()
    }
    
    func setSymbols() {
        let selectedSymbols = allSymbols.shuffled().prefix(14)
        symbols = (selectedSymbols + selectedSymbols).shuffled()
    }
    func resetGame() {
        setSymbols()
        shownCards = []
        matchedCards = []
        score = 0
    }

    func showCard(index: Int, symbol: String) {
        // Arrêter si on clique sur une paire déjà trouvée
        guard !matchedCards.contains(symbol) else { return }

        // Ajouter l’index aux cartes montrées s’il n’y a qu’une seule carte montrée
        guard shownCards.count < 2 else {
            shownCards = [index]
            return
        }

        // Ajouter l’index au tableau des cartes montrées si cet index n’y est pas déjà
        if !shownCards.contains(index) {
            shownCards.append(index)
        }

        // Arrêter s’il n’y a qu’une seule carte montrée
        guard shownCards.count == 2 else {
            return
        }

        // Incrémenter le compteur de tentatives quand deux cartes sont montrées
        score += 1

        //  Lancer une alerte si le score maximum est dépassé
        if score >= maxScore {
            activeAlert = .maxScore
            showAlert = true
            return
        }

        // Ajouter le symbole au tableau des symboles trouvés si la première carte est identique à la deuxième
        let firstSymbol = symbols[shownCards[0]]
        let secondSymbol = symbols[shownCards[1]]
        if firstSymbol == secondSymbol {
            matchedCards.append(firstSymbol)
            shownCards = []
        }

        // Victoire si le nombre de cartes trouvées est égal à la moitié des symboles
        guard matchedCards.count * 2 == symbols.count else { return }
        victory = true

        // Mettre à jour le meilleur score s’il est battu
        if bestScore == 0 || score < bestScore {
            bestScore = score
        }
    }
}

enum ScoreColor {
    case lowerThanBestScore(Color)
    case equalThanBestScore(Color)
    case greaterThanBestScore(Color)
}
