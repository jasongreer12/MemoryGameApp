//
//  CardGameViewModel.swift
//  MemoryGame
//
//  Created by Jason Greer on 3/5/25.
//

import SwiftUI

class CardGameViewModel: ObservableObject {
    @Published var cards: [MemoryCard] = []
    @Published var score: Int = 0;    @Published var moves: Int = 0
    @Published var gameOver: Bool = false
    
    private var firstSelectedCardIndex: Int? = nil // first card index
    
    private var emojiPairs: [String] = ["🤣", "🥸", "😎", "🥶", "🤠", "🐧"]
    
    init() {
        startNewGame()
    }
    
    func startNewGame() {
        score = 0
        moves = 0
        gameOver = false
        firstSelectedCardIndex = nil
        
        cards = []
        for emoji in emojiPairs {
            let card1 = MemoryCard(content: emoji)
            let card2 = MemoryCard(content: emoji)
            cards.append(contentsOf: [card1, card2])
        }
        
        shuffleCards()
    }
    
    func shuffleCards() {
        cards.shuffle()
    }
    
    func selectCard(_ selectedCard: MemoryCard) {
        guard let selectedIndex = cards.firstIndex(where: { $0.id == selectedCard.id }) else {
            return
        }
        
        cards[selectedIndex].isTurnedOver = true
        
        if let firstIndex = firstSelectedCardIndex {
            moves += 1
            
            if cards[selectedIndex].content == cards[firstIndex].content {
                cards[selectedIndex].isMatched = true
                cards[firstIndex].isMatched = true
                score += 2
                if cards.allSatisfy({ $0.isMatched }) {
                    gameOver = true
                }
            } else {
                if score > 0 { score -= 1 }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.cards[selectedIndex].isTurnedOver = false
                    self.cards[firstIndex].isTurnedOver = false
                }
            }
            firstSelectedCardIndex = nil
        } else {
            firstSelectedCardIndex = selectedIndex
        }

    }
    
    func dealCards() {
        for index in cards.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
            }
        }
    }
}
