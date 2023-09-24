//
//  GameEngine.swift
//  Composable2048
//
//  Created by Tornike on 08/09/2023.
//

import Foundation

/// `GameEngine` encapsulates the core logic of the 2048 game.
class GameEngine {
  /// Represents the empty game board initialized with zeros.
  private var emptyBoard = Matrix.zeros(rows: 4, columns: 4)
  /// Holds the total points scored in the game.
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

  /// Generates a random tile value based on a predefined distribution.
  /// - Returns: Returns `2` with 90% probability and `4` with 10% probability.
  func isGameOver(_ board: Matrix) -> Bool {
    return !board.canCombineValues
  }

  /// Adds a random number to a random empty tile on the board.
  /// - Parameter board: The current game board.
  /// - Returns: A tuple containing the new board and the coordinates of the added tile.
  func addNumber(_ board: Matrix) -> (newBoard: Matrix, addedTile: (Int,Int)?) {
    let emptyTile = board.randomIndex(for: .zero)
    var newBoard = board

    if let emptyTile = emptyTile {
      newBoard[emptyTile.row, emptyTile.column] = Double(randomElement)
    }

    return (newBoard, emptyTile)
  }

  /// Slides the non-zero elements in a row to the right, filling the gaps with zeros.
  /// - Parameter row: An array of integers representing a row in the game board.
  /// - Returns: A new array where all non-zero elements are moved to the right, and zeros fill the remaining positions.
  /*
   Example:
   Initial row: [2, 0, 4, 0]
   tilesWithNumbers: [2, 4]
   emptyTiles: 2
   arrayOfZeros: [0, 0]

   Returned row: [0, 0, 2, 4]
   */
  func slide(_ row: [Int]) -> [Int] {
    /// Filter out the zeros from the row and keep the non-zero elements.
    /// This step retains the relative order of the non-zero elements.
    let tilesWithNumbers = row.filter { $0 > .zero }

    /// Calculate the number of zeros in the original row.
    let emptyTiles = row.count - tilesWithNumbers.count

    /// Create an array with zeros, the count of which equals the number of zeros in the original row.
    let arrayOfZeros = Array(repeating: Int.zero, count: emptyTiles)

    /// Concatenate the array of zeros at the beginning and the non-zero elements at the end.
    /// This effectively slides the non-zero elements to the right.
    return arrayOfZeros + tilesWithNumbers
  }

  /// Combines adjacent tiles with the same value in a row.
  /// - Parameter row: A row from the game board.
  /// - Returns: A new row array after performing the combine operation.
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

  /// Flips the board horizontally.
  /// - Parameter board: The current game board.
  /// - Returns: A new board that is the horizontal flip of the input board.
  func flip(_ board: Matrix) -> Matrix {
    var flipped = emptyBoard
    for row in 0..<board.rows {
      for col in 0..<board.columns {
        flipped[row, col] = board[row, board.columns - col - 1]
      }
    }
    return flipped
  }

  /// Rotates the board 90 degrees counterclockwise.
  /// - Parameter board: The current game board.
  /// - Returns: A new board that is rotated 90 degrees counterclockwise.
  func rotate(_ board: Matrix) -> Matrix {
    var newBoard = emptyBoard
    // Iterate through all rows and columns of the original board.
    for row in 0..<board.rows {
      for column in 0..<board[row: row].count {
        // Rotate the board 90 degrees counterclockwise by swapping row and column indices.
        newBoard[row: row][column] = board[row: column][row]
      }
    }

    // Return the rotated board.
    return newBoard
  }

  /// Private helper function to slide and combine rows of the board.
  /// - Parameter board: The current game board.
  /// - Returns: A new board after sliding and combining rows.
  private func operateRows(_ board: Matrix) -> Matrix {
    let data = board.array.map { grid in
      let intGrid = grid.map { Int($0) }
      let operatedRow = slideAndCombine(intGrid)
      return operatedRow.map { Double($0) }
    }
    return Matrix(data)
  }

  /// Moves the board in a specific direction.
  /// - Parameters:
  ///   - board: The current game board.
  ///   - direction: The direction to move the board.
  /// - Returns: A tuple containing the new board and the points scored during this move.
  func push(_ board: Matrix, to direction: Direction) -> (newBoard: Matrix, movements: [TileMovement], scoredPoints: Int) {
    var newBoard = board
    points = .zero
    var movements: [TileMovement] = []

    switch direction {
    case .right:
      for row in 0..<board.rows {
        var lastCol: Int? = nil
        for col in (0..<board.columns).reversed() {
          if board[row, col] != 0 {
            if let lastColUnwrapped = lastCol {
              movements.append(TileMovement(from: (row, col), to: (row, lastColUnwrapped)))
            } else {
              lastCol = col
            }
          }
        }
      }
      newBoard = (board |> pushRight)
    case .up:    newBoard = (board |> pushUp)
    case .left:  newBoard = (board |> pushLeft)
    case .down:  newBoard = (board |> pushDown)
    }

    return (newBoard, movements, points)
  }

  func mockBoard() -> Matrix {
    // Initialize an empty 4x4 board
    var board = Matrix([
      [2.0, 4.0, 8.0, 16.0],
      [0.0, 0.0, 0.0, 256.0],
      [0.0, 0.0, 32.0, 0.0],
      [1024.0, 0.0, 0.0, 64.0]
    ])

    return board
  }

  /// Combines and slides the tiles in a row using the game's logic.
  /// This function is a composite of the slide and combine functions, effectively performing both operations.
  /// - Parameter row: A row from the game board represented as an array of integers.
  /// - Returns: A new row array after performing the slide and combine operations.
  private func slideAndCombine(_ row: [Int]) -> [Int] {
    row
    |> slide  // First, slide the non-zero elements to the right.
    |> combine  // Combine any adjacent, identical elements.
    |> slide  // Finally, slide again to fill any gaps created by the combine operation.
  }

  /// Moves the board upwards, combining any adjacent, identical tiles.
  /// - Parameter board: The current game board.
  /// - Returns: A new board after the 'up' movement operation.
  private func pushUp(_ board: Matrix) -> Matrix {
    board
    |> rotate  // Rotate the board 90 degrees counterclockwise.
    |> flip  // Flip the board horizontally.
    |> operateRows  // Slide and combine each row.
    |> flip  // Flip the board back to its original orientation.
    |> rotate  // Rotate the board back to its original orientation.
  }

  /// Moves the board downwards, combining any adjacent, identical tiles.
  /// - Parameter board: The current game board.
  /// - Returns: A new board after the 'down' movement operation.
  private func pushDown(_ board: Matrix) -> Matrix {
    board
    |> rotate  // Rotate the board 90 degrees counterclockwise.
    |> operateRows  // Slide and combine each row.
    |> rotate  // Rotate the board back to its original orientation.
  }

  /// Moves the board to the left, combining any adjacent, identical tiles.
  /// - Parameter board: The current game board.
  /// - Returns: A new board after the 'left' movement operation.
  private func pushLeft(_ board: Matrix) -> Matrix {
    board
    |> flip  // Flip the board horizontally.
    |> operateRows  // Slide and combine each row.
    |> flip  // Flip the board back to its original orientation.
  }

  /// Moves the board to the right, combining any adjacent, identical tiles.
  /// - Parameter board: The current game board.
  /// - Returns: A new board after the 'right' movement operation.
  private func pushRight(_ board: Matrix) -> Matrix {
    board
    |> operateRows  // Slide and combine each row.
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
