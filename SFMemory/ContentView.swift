//
//  ContentView.swift
//  SFMemory
//
//  Created by Vincent Caronnet on 02/10/2020.
//

import SwiftUI

struct ContentView: View {
    @State var isActive : Bool = false
    @AppStorage("bestScore") var bestScore: Int = 0

    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 6) {
                    Image("logo-picto-bw")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80, alignment: .top)
                    Text("SF Memory")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                }
                Spacer()
                Group {
                    if bestScore > 0 || true {
                        Text("Mon meilleur score :")
                            .font(.system(size: 24, weight: .light, design: .rounded))
                        HStack {
                            Image(systemName: "star")
                            Text(String(bestScore))
                                .font(.system(size: 30, weight: .light, design: .rounded))
                            Text("essais")
                                .offset(y: 1)
                            Image(systemName: "star")
                        }
                        .font(.system(size: 24, weight: .ultraLight, design: .rounded))
                    }
                }
                .padding(0)
                Spacer()
                NavigationLink("Nouvelle partie", destination: GameView(rootIsActive: $isActive), isActive: $isActive)
                    .customButton(Color.blue)
            }
            .modifier(MainViewModifier())
            .padding(.top, 100)
            .navigationBarHidden(true)
        }.environmentObject(GameData())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone 11", "iPhone 8"], id: \.self) { deviceName in
            ContentView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
