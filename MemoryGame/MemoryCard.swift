//
//  Memory.swift
//  MemoryGame
//
//  Created by Jason Greer on 3/5/25.
//

import SwiftUI


struct MemoryCard: Identifiable {
    let id: UUID = UUID()
    var isTurnedOver: Bool = false
    var isMatched: Bool = false
    var content: String
    var position: CGFloat = 0.0
}
