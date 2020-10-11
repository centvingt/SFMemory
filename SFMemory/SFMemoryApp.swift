//
//  SFMemoryApp.swift
//  SFMemory
//
//  Created by Vincent Caronnet on 02/10/2020.
//

import SwiftUI

@main
struct SFMemoryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GameData())
        }
    }
}
