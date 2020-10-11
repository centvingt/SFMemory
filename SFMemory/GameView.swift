//
//  GameView.swift
//  SFMemory
//
//  Created by Vincent Caronnet on 02/10/2020.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameData: GameData

    var body: some View {
        VStack(spacing: 10) {
            GameHeaderView()

            CardsGridView()

            Group {
                if !gameData.victory {
                    Button(action: {
                        gameData.resetGame()
                        self.gameData.rootIsActive.toggle()
                    }, label: {
                        Text("Abandonner")
                    }).customButton(Color.red)
                } else {
                    Button(action: {
                        gameData.resetGame()
                        self.gameData.rootIsActive.toggle()
                    }, label: {
                        Text("Retour à l’accueil")
                    }).customButton(Color.blue)
                }
            }
        }
        .modifier(MainViewModifier())
        .navigationBarHidden(true)
        .alert(isPresented: $gameData.showAlert, content: {
            switch gameData.activeAlert {
            case .victory:
                return Alert(
                    title: Text("Bravo !"),
                    message: Text("Vous avez gagné !"),
                    dismissButton: .default(Text("Parfait !"))
                )
            case .maxScore:
                return Alert(
                    title: Text("Perdu !"),
                    message: Text("Vous avez dépassé le nombre d’essais maximum"),
                    dismissButton: .default(Text("C’est compris"), action: {
                        gameData.resetGame()
                        self.gameData.rootIsActive.toggle()
                    })
                )
            }
        })
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone 11", "iPhone 8"], id: \.self) { deviceName in
            GameView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .environmentObject(GameData())
        }
    }
}

