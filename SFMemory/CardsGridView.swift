//
//  CardsGridView.swift
//  SFMemory
//
//  Created by Vincent Caronnet on 04/10/2020.
//

import SwiftUI

struct CardsGridView: View {
    @EnvironmentObject var gameData: GameData

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3.0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .customBackground(gameData.scoreColor)
            Group {
                let padding: CGFloat = 20
                let spacing: CGFloat = 10
                let verticalSpaces: CGFloat = (padding * 2) + (spacing * 6)
                let columns: [GridItem] = Array(
                    repeating: .init(.flexible(),
                    spacing: spacing),
                    count: 4
                )
                GeometryReader(content: { geometry in
                    let geoWidth = geometry.size.width
                    let geoHeight = geometry.size.height
                    let cardLength = (geoHeight - verticalSpaces) / 7
                    let gridWidth = (cardLength * 4) + (spacing * 3)
                    let gridHeight = geoHeight - (padding * 2)
                    let gridOffset = (geoWidth - gridWidth - (padding * 2)) / 2

                    LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                        ForEach((0...27), id: \.self) {
                            CardView(cardLength: cardLength, index: $0, symbol: gameData.symbols[$0])
                        }
                    }
                    .offset(x: gridOffset)
                    .frame(width: abs(gridWidth))
                    .frame(height: abs(gridHeight))
                    .padding(.all, padding)
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// Faire un fakeSymbols pour faire la preview
//struct CardsGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardsGridView(symbols: Game.shared.symbols)
//            .padding()
//    }
//}


