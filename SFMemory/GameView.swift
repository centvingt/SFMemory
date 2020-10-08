//
//  GameView.swift
//  SFMemory
//
//  Created by Vincent Caronnet on 02/10/2020.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameData: GameData

    @Binding var rootIsActive : Bool

    var body: some View {
        VStack(spacing: 10) {
            GameHeaderView()

            CardsGridView(symbols: Game.shared.symbols)

            Group {
                if !gameData.victory {
                    Button(action: {self.rootIsActive.toggle()}, label: {
                        Text("Abandonner")
                    }).customButton(Color.red)
                } else {
                    Button(action: {self.rootIsActive.toggle()}, label: {
                        Text("Retour à l’accueil")
                    }).customButton(Color.blue)
                }
            }
        }
        .modifier(MainViewModifier())
        .navigationBarHidden(true)
        .alert(isPresented: $gameData.victory, content: {
            Alert(title: Text("Bravo !"), message: Text("Vous avez gagné !"), dismissButton: .default(Text("OK")))
        })
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone 11", "iPhone 8"], id: \.self) { deviceName in
            GameView(rootIsActive: .constant(true))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .environmentObject(GameData())
        }
    }
}

