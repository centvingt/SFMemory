//
//  CardView.swift
//  SFMemory
//
//  Created by Vincent Caronnet on 03/10/2020.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var gameData: GameData
    @AppStorage("bestScore") var bestScore: Int = 0

    let cardLength: CGFloat
    let index: Int
    let symbol: String

    var body: some View {

        Group {
            if gameData.shownCards.contains(index) || gameData.matchedCards.contains(symbol) {
                if gameData.matchedCards.contains(symbol) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 3)
                            .customBackground(Color.white)
                        Image(systemName: symbol)
                            .foregroundColor(Color.blue)
                    }
                } else {
                    Image(systemName: symbol)
                }
            } else {
                Text("?")
            }
        }
        .onTapGesture{
            showCard(index: index)
        }
        .font(.system(size: 36, weight: .regular, design: .rounded))
        .frame(width: abs(cardLength), height: abs(cardLength))
        .aspectRatio(1, contentMode: .fit)
        .customBorder(Color.white)
    }

    func showCard(index: Int) {
        // Arrêter si on clique sur une paire déjà trouvée
        guard !gameData.matchedCards.contains(symbol) else { return }

        // Ajouter l’index aux cartes montrées s’il n’y a qu’une seule carte montrée
        guard gameData.shownCards.count < 2 else {
            gameData.shownCards = [index]
            return
        }

        // Ajouter l’index au tableau des cartes montrées si cet index n’y est pas déjà
        if !gameData.shownCards.contains(index) {
            gameData.shownCards.append(index)
        }

        // Arrêter s’il n’y a qu’une seule carte montrée
        guard gameData.shownCards.count == 2 else {
            return
        }

        // Incrémenter le compteur de tentatives quand deux cartes sont montrées
        gameData.score += 1

        // Ajouter le symbole au tableau des symboles trouvés si la première carte est identique à la deuxième
        let firstSymbol = Game.shared.symbols[gameData.shownCards[0]]
        let secondSymbol = Game.shared.symbols[gameData.shownCards[1]]
        if firstSymbol == secondSymbol {
            gameData.matchedCards.append(firstSymbol)
            gameData.shownCards = []
        }
        
        // Victoire si le nombre de cartes trouvées est égal à la moitié des symboles
        guard gameData.matchedCards.count * 2 == Game.shared.symbols.count else { return }
        gameData.victory = true
        
        // Mettre à jour le meilleur score s’il est battu
        if gameData.score < bestScore {
            bestScore = gameData.score
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue
            CardView(cardLength: 100, index: 0, symbol: "star")
                .environmentObject(GameData())
        }
    }
}
