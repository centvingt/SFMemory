//
//  CardView.swift
//  SFMemory
//
//  Created by Vincent Caronnet on 03/10/2020.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var gameData: GameData

    let cardLength: CGFloat
    let index: Int
    let symbol: String

    var fontSize: CGFloat {
        if cardLength > 58 {
            return 36
        } else {
            return (cardLength * 36) / 58
        }
    }

    var body: some View {
        Group {
            if gameData.shownCards.contains(index) || gameData.matchedCards.contains(symbol) {
                if gameData.matchedCards.contains(symbol) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 3)
                            .customBackground(Color.white)
                        Image(systemName: symbol)
                            .foregroundColor(gameData.scoreColor)
                    }
                } else {
                    Image(systemName: symbol)
                }
            } else {
                Text("?")

            }
        }
        .onTapGesture{
            gameData.showCard(index: index, symbol: symbol)
        }
        .font(.system(size: fontSize, weight: .regular, design: .rounded))
        .frame(width: abs(cardLength), height: abs(cardLength))
        .aspectRatio(1, contentMode: .fit)
        .customBorder(Color.white)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue
            CardView(cardLength: 44, index: 0, symbol: "textformat.123")
                .environmentObject(GameData())
        }
    }
}
