//
//  CardView.swift
//  MemoryGame
//
//  Created by Jason Greer on 3/5/25.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var viewModel: CardGameViewModel
    
    let card: MemoryCard
    @State private var dragTracker: CGSize = .zero
    
    var body: some View {
        ZStack {
            cardFront
            cardBack
        }
        .frame(width: 100, height: 150)
        .rotation3DEffect(
            .degrees(card.isTurnedOver ? 0 : 180),
            axis: (x: 0, y: 1, z:0)
        )
        .offset(dragTracker)
        .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragTracker = value.translation
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                dragTracker = .zero
                            }
                        }
                )
        .onTapGesture(count: 2) {
            withAnimation {
                viewModel.selectCard(card)
            }
        }
            }
    private var cardFront: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .overlay(
                Text(card.content)
                    .font(.title)
                    .font(.largeTitle)
            )
            .opacity(card.isTurnedOver ? 1 : 0)
    }
    private var cardBack: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .opacity(card.isTurnedOver ? 0 : 1)
        
    }

}

