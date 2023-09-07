//
//  Matrix+Math.swift
//  Composable2048
//
//  Created by Tornike on 08/09/2023.
//

import Foundation

extension Matrix {
  var isMatrixEmpty: Bool {
    return sum() == .zero
  }

  var canCombineValues: Bool {
    guard __hasZeros == false else { return true }
    print(self.debugDescription)
    print("Rows: \(self.rows)")
    print("Columns: \(self.columns)")
    for row in 0..<self.rows - 1 {
      for column in 0..<self.columns - 1 {
        if canCombineItemAt(row: row, column: column) {
          return true
        }
      }
    }
    return false
  }

  func randomIndex(for value: Int) -> (row: Int, column: Int)? {
    return __indexesWith(value).randomElement()
  }

  func isEqual(_ matrix: Matrix) -> Bool {
    return self == matrix
  }

  func canCombineItemAt(row: Int, column: Int) -> Bool {
    let verticallyCombinable = __canCombineVertically(row: row, column: column)
    let horizontallyCombinable = __canCombineHorizontally(row: row, column: column)
    return verticallyCombinable || horizontallyCombinable
  }

  private func __indexesWith(_ value: Int) -> [(Int, Int)] {
    var indexes: [(Int, Int)] = []

    for row in 0..<count {
      indexes.append(contentsOf: __indexesOf(row, with: value))
    }

    return indexes
  }

  private func __indexesOf(_ row: Int, with value: Int)  -> [(Int, Int)] {
    var indexes: [(Int, Int)] = []
    for column in 0..<count {
      if self[row, column] == Double(value) {
        indexes.append((row,column))
      }
    }
    return indexes
  }

  private var __hasZeros: Bool {
    joined().contains(0)
  }

  private func __canCombineVertically(row: Int, column: Int) -> Bool {
    print(self.debugDescription)
    print("[\(row)] - [\(column)]")
    print(self[row: row][column])

    print("[\(row+1)] - [\(column)]")
    print(self[row: row + 1][column])
    return row != count - 1 && self[row: row][column] == self[row: row+1][column]
  }

  private func __canCombineHorizontally(row: Int, column: Int) -> Bool {
    print(self.debugDescription)
    print("-----------------------")

    print("[\(row)] - [\(column)]")
    print(self[row: row][column])

    print("[\(row)] - [\(column+1)]")
    print(self[row: row][column+1])

    return column != count - 1 && self[row: row][column] == self[row: row][column + 1]
  }
}
