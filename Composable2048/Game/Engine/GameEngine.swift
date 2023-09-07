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
}
