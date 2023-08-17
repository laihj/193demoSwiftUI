//
//  MemoryGame.swift
//  workout2
//
//  Created by laihj on 2023/8/16.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards:Array<Card>
    
    mutating func choose(_ card:Card) {
        let cardIndex = index(of: card);
        cards[cardIndex].isFaceUp.toggle()
        print("\(cards)");
    }
    
    func index(of card:Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index;
            }
        }
        return NSNotFound
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
        var isFaceUp = true
        var isMatched = false
        var content:CardContent
        var id = UUID()
    }
    
}
