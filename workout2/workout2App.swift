//
//  workout2App.swift
//  workout2
//
//  Created by laihj on 2023/7/5.
//

import SwiftUI

@main
struct workout2App: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(game:game)
        }
    }
}
