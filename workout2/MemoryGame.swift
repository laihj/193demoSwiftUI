//
//  MemoryGame.swift
//  workout2
//
//  Created by laihj on 2023/8/16.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards:Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard:Int?
    
    mutating func choose(_ card:Card) {
        if let cardIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[cardIndex].isFaceUp,
           !cards[cardIndex].isMatched
        {
            if let poIndex = indexOfTheOneAndOnlyFaceUpCard {
                if(cards[poIndex].content == cards[cardIndex].content) {
                    cards[poIndex].isMatched = true
                    cards[cardIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = cardIndex
            }
            
            cards[cardIndex].isFaceUp.toggle()
        }
    }
    
    init(piarsOfCard:Int, createCardContent:(Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<piarsOfCard {
            let content = createCardContent(index)
            cards.append(Card(content:content));
            cards.append(Card(content:content));
        }
        
    }
    
    struct Card : Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content:CardContent
        var id = UUID()
    }
    
}
