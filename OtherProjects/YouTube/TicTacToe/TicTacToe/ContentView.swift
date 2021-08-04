//
//  ContentView.swift
//  TicTacToe
//
//  Created by Sean Coughlin on 7/28/21.
//

// Sean Allen Tutorial
// https://youtu.be/MCLiPW2ns2w
// Day 1 13:35 in
// Day 2 23:39

// Cmd + shift + A for light/dark in simulator

import SwiftUI

// Needs to be moved inside
// Right now it will work but setup as global variable
let columns: [GridItem] = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]

// Will need to be refractored later
struct ContentView: View {
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isHumansTurn = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns, spacing: 1) {
                    ForEach(0 ..< 9) { i in
                        ZStack {
                            Circle()
                                .foregroundColor(.red).opacity(0.5)
                                .frame(width: geometry.size.width / 3 - 15,
                                       height: geometry.size.height / 5 - 15)
                            Image(systemName: moves[i]?.indicator ?? "") // Using SF symbols
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            if isSquareOccupied(in: moves, forIndex: i) { return }
                            moves[i] = Move(player: isHumansTurn ? .human : .computer, boardIndex: i)
                            isHumansTurn.toggle()
                        }
                    }
                }
                Spacer()
            }
            .padding(0)
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        // Will check each move in board, if not nil then going to check if matches the index
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    func determineComputerMove(in moves: [Move?]) -> Int {
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
