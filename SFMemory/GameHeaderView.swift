//
//  GameHeaderView.swift
//  SFMemory
//
//  Created by Vincent Caronnet on 04/10/2020.
//

import SwiftUI

struct GameHeaderView: View {
    @EnvironmentObject var gameData: GameData
    @AppStorage("bestScore") var bestScore: Int = 0

    var body: some View {
        HStack(alignment: .bottom) {
            HStack(alignment: .bottom, spacing: 6) {
                Image("logo-picto-bw")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 47, height: 47, alignment: .top)
                Text("SF Memory")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
            }
            Spacer()
            Group {
                if gameData.score == 0 || gameData.score == bestScore {
                    HStack(alignment: .firstTextBaseline, spacing: 3) {
                        Text(String(gameData.score)).fontWeight(.medium).offset(y: 1).font(.system(size: 30))
                        Text("essais").fontWeight(.light).font(.system(size: 20))
                    }.foregroundColor(.blue)
                    .offset(y: 1)
                }
                if  gameData.score != 0 && gameData.score < bestScore {
                    HStack(alignment: .firstTextBaseline, spacing: 3) {
                        Text(String(gameData.score)).fontWeight(.medium).offset(y: 1).font(.system(size: 30))
                        Text("essais").fontWeight(.light).font(.system(size: 20))
                    }.foregroundColor(.green)
                    .offset(y: 1)
                }
                if gameData.score > bestScore {
                    HStack(alignment: .firstTextBaseline, spacing: 3) {
                        Text(String(gameData.score)).fontWeight(.medium).offset(y: 1).font(.system(size: 30))
                        Text("essais").fontWeight(.light).font(.system(size: 20))
                    }.foregroundColor(.orange)
                    .offset(y: 1)
                }
            }
        }
    }
}

struct GameHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        GameHeaderView()
    }
}
