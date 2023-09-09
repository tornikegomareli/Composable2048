//
//  ContentView.swift
//  Composable2048
//
//  Created by Tornike on 06/09/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      Board(board: GameEngine().mockBoard())
        .padding()
    }
}

#Preview {
    ContentView()
}
