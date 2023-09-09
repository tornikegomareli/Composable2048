//
//  Moves.swift
//  Composable2048
//
//  Created by Tornike on 10/09/2023.
//

import SwiftUI

struct Moves: View {
  let moves: Int
  
  init(_ moves: Int) {
    self.moves = moves
  }
  
  var body: some View {
    HStack {
      Text("moves: \(moves)").bold()
    }
    .font(.system(size: 16, weight: .regular, design: .rounded))
    .foregroundColor(.white50)
  }
}
struct Moves_Previews: PreviewProvider {
  static var previews: some View {
    Moves(123)
  }
}
