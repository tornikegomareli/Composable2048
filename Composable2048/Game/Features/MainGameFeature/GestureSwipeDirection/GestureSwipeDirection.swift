//
//  GestureSwipeDirection.swift
//  Composable2048
//
//  Created by Tornike on 10/09/2023.
//

import Foundation

func detectSwipeDirection(_ horizontalAmount: CGFloat, _ verticalAmount: CGFloat) -> GameEngine.Direction? {
  if abs(horizontalAmount) > abs(verticalAmount) {
    return horizontalAmount < 0 ? .left : .right
  } else {
    return verticalAmount < 0 ? .up : .down
  }
}
