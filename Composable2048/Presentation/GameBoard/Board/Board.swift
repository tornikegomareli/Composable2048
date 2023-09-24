//
//  Board.swift
//  Composable2048
//
//  Created by Tornike on 08/09/2023.
//

import Foundation
import SwiftUI

struct Board: View {
  var board: Matrix
  var addedTile: (Int, Int)? = nil
  var movements: [TileMovement] = []

  private func wasAdded(row: Int, column: Int) -> Bool {
    addedTile?.0 == row && addedTile?.1 == column
  }

  private func findMovement(row: Int, column: Int) -> TileMovement? {
    return movements.first { $0.from.row == row && $0.from.col == column }
  }

  var body: some View {
    VStack {
      ForEach(0..<self.board.grid.count / 4, id: \.self) { row in
        HStack {
          ForEach(
            0..<self.board[row: row].count,
            id: \.self
          ) { column in
            if self.wasAdded(row: row, column: column) {
              Tile(
                Int(self.board[row: row][column]),
                wasAdded: self.wasAdded(row: row, column: column),
                movement: self.findMovement(row: row, column: column)
              )
            } else {
              Tile(Int(self.board[row: row][column]), wasAdded: false)
            }

          }
        }
        .padding(4)
      }
    }
    .padding(8)
    .background(Color.boardBackground)
    .cornerRadius(4)
  }
}

#if DEBUG
struct Board_Previews: PreviewProvider {
    static var previews: some View {
      Board(board: GameEngine().mockBoard())
    }
}
#endif
