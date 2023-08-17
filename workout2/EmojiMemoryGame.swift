//
//  EmojiMemoryGame.swift
//  workout2
//
//  Created by laihj on 2023/8/16.
//

import Foundation

class EmojiMemoryGame : ObservableObject {
    
    
    static let emojis = ["🥰","😨","☠️","😵‍💫","😵‍💫","🥰","😨","☠️","😵‍💫","😵‍💫","🥰","😨","☠️","😵‍💫","😵‍💫"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(piarsOfCard: 6) { index in emojis[index]
        }
    }
    
    @Published private var model:MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(card:MemoryGame<String>.Card) {
        model.choose(card)
    }
}
