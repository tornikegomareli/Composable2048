//
//  MoveModifier.swift
//  Composable2048
//
//  Created by Tornike on 24/09/2023.
//

import Foundation
import SwiftUI

struct MoveModifier: AnimatableModifier {
  var start: CGPoint
  var end: CGPoint
  var progress: CGFloat
  var shouldMove: Bool

  var animatableData: CGFloat {
    get {
      progress
    }

    set {
      progress = newValue
    }
  }

  func body(content: Content) -> some View {
    if shouldMove {
      let posX = start.x + (end.x - start.x) * progress
      let posY = start.y + (end.y - start.y) * progress
      return AnyView(content.position(x: posX, y: posY))
    }

    return AnyView(content)
  }
}
