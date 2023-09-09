//
//  GameEngine.swift
//  Composable2048
//
//  Created by Tornike on 08/09/2023.
//

import Foundation

class GameEngine {
  private var emptyBoard = Matrix.zeros(rows: 4, columns: 4)
  private var points: Int = 0

  /// Generates a random element based on a predefined distribution.
  /// - Returns: 2 with 90% probability, 4 with 10% probability.
  private var randomElement: Int {
    let upperBound = 10
    let threshold = 9
    let commonElement = 2
    let rareElement = 4

    return Int.random(in: 0...upperBound) < threshold ? commonElement : rareElement
  }

  func isGameOver(_ board: Matrix) -> Bool {
    return !board.canCombineValues
  }

  func addNumber(_ board: Matrix) -> (newBoard: Matrix, addedTile: (Int,Int)?) {
    let emptyTile = board.randomIndex(for: .zero)
    var newBoard = board

    if let emptyTile = emptyTile {
      newBoard[emptyTile.row, emptyTile.column] = Double(randomElement)
    }
 
    return (newBoard, emptyTile)
  }

  func slide(_ row: [Int]) -> [Int] {
    let tilesWithNumbers = row.filter { $0 > .zero }
    let emptyTiles = row.count - tilesWithNumbers.count
    let arrayOfZeros = Array(repeating: Int.zero, count: emptyTiles)
    return arrayOfZeros + tilesWithNumbers
  }

  func combine(_ row: [Int]) -> [Int] {
    var newRow = row
    for column in (1...row.count - 1).reversed() {
      let prevColumn = column - 1
      let left = newRow[column]
      let right = newRow[prevColumn]
      if left == right {
        newRow[column] = left + right
        newRow[prevColumn] = .zero
        points += left + right
      }
    }
    return newRow
  }

  func flip(_ board: Matrix) -> Matrix {
    var flipped = emptyBoard
    for row in 0..<board.rows {
      for col in 0..<board.columns {
        flipped[row, col] = board[row, board.columns - col - 1]
      }
    }
    return flipped
  }

  func rotate(_ board: Matrix) -> Matrix {
      var newBoard = emptyBoard
      for row in 0..<board.count {
        for column in 0..<board.rows {
              newBoard[row, column] = board[column, row]
          }
      }
      return newBoard
  }

  private func operateRows(_ board: Matrix) -> Matrix {
    let data = board.array.map { grid in
      let intGrid = grid.map { Int($0) }
      let operatedRow = slideAndCombine(intGrid)
      return operatedRow.map { Double($0) }
    }
    return Matrix(data)
  }

  func push(_ board: Matrix, to direction: Direction) -> (newBoard: Matrix, scoredPoints: Int) {
      var newBoard = board
      points = .zero

      switch direction {
      case .right: newBoard = (board |> pushRight)
      case .up:    newBoard = (board |> pushUp)
      case .left:  newBoard = (board |> pushLeft)
      case .down:  newBoard = (board |> pushDown)
      }

      return (newBoard, points)
  }

  private func slideAndCombine(_ row: [Int]) -> [Int] {
      row
          |> slide
          |> combine
          |> slide
  }

  private func pushUp(_ board: Matrix) -> Matrix {
      board
          |> rotate
          |> flip
          |> operateRows
          |> flip
          |> rotate
  }

  private func pushDown(_ board: Matrix) -> Matrix {
      board
          |> rotate
          |> operateRows
          |> rotate
  }

  private func pushLeft(_ board: Matrix) -> Matrix {
      board
          |> flip
          |> operateRows
          |> flip
  }

  private func pushRight(_ board: Matrix) -> Matrix {
      board
          |> operateRows
  }
}

extension GameEngine {
  /// Enum based on Direction
  enum Direction {
    case right
    case up
    case left
    case down
  }
}

