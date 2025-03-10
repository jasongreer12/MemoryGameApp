//
//  MainGameView.swift
//  MemoryGame
//
//  Created by Jason Greer on 3/5/25.
//

import SwiftUI

struct MainGameView: View {
    @ObservedObject var gameViewModel = CardGameViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            ControlPanel(gameViewModel: gameViewModel)
                .padding(.horizontal, 24)
                .padding(.top, 24)
            
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(gameViewModel.cards) { card in
                    CardView(viewModel: gameViewModel, card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                }
            }
            .padding([.horizontal, .bottom], 24)
        }
        .background(Color(white: 0.9))
        .ignoresSafeArea()
    }
}
