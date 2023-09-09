//
//  App+Dependencies.swift
//  Composable2048
//
//  Created by Tornike on 10/09/2023.
//

import Foundation
import Dependencies

extension DependencyValues {
  var gameEngine: GameEngine {
    get { self[GameEngine.self] }
    set { self[GameEngine.self] = newValue }
  }
}

extension GameEngine: DependencyKey {
  public static var liveValue: GameEngine {
    return GameEngine()
  }
}
