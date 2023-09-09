//
//  Matrix+CustomDebugStgringConvertible.swift
//  Composable2048
//
//  Created by Tornike on 08/09/2023.
//

import Foundation

extension Matrix: CustomDebugStringConvertible {
  public var debugDescription: String {
    var description = "\n"
    for row in 0..<rows {
      var rowDescription = "["
      for column in 0..<columns {
        rowDescription += "\(self[row, column])"
        if column < columns - 1 {
          rowDescription += ", "
        }
      }
      rowDescription += "]"
      description += rowDescription + "\n"
    }
    return description
  }
}

extension Matrix: Equatable {}
