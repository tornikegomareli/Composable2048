//
//  Tile.swift
//  Composable2048
//
//  Created by Tornike on 08/09/2023.
//

import SwiftUI

struct Tile: View {
  let value: Int
  let wasAdded: Bool
  let movement: TileMovement?

  private let style: TileStyle
  private let title: String
  private let size: CGFloat = 70
  private let spacing: CGFloat = 10  // Set this based on your layout

  func position(forRow row: Int, column: Int, tileSize: CGFloat, spacing: CGFloat) -> CGPoint {
    let x = CGFloat(column) * (tileSize + spacing) + tileSize / 2
    let y = CGFloat(row) * (tileSize + spacing) + tileSize / 2
    return CGPoint(x: x, y: y)
  }

  @State private var animationProgress: CGFloat = 0

  init(_ value: Int, wasAdded: Bool = false, movement: TileMovement? = nil) {
    self.wasAdded = wasAdded
    self.value = value
    self.movement = movement

    style = TileStyle(value)
    title = value == 0 ? "" : value.description
  }

  private var fontSize: CGFloat {
    switch value {
    case 1, 2:
      return 30
    case 3:
      return 28
    default:
      return 22
    }
  }

  private var shadowColor: Color {
    value == 2048 ? .yellow : .clear
  }

  var body: some View {
    let start = position(
      forRow: movement?.from.row ?? 0,
      column: movement?.from.col ?? 0,
      tileSize: size,
      spacing: spacing
    )

    let end = position(
      forRow: movement?.to.row ?? 0,
      column: movement?.to.col ?? 0,
      tileSize: size,
      spacing: spacing
    )

    return Text(title)
      .font(.system(size: fontSize, weight: .black, design: .monospaced))
      .foregroundColor(style.foregroundColor)
      .frame(width: size, height: size)
      .background(style.backgroundColor)
      .cornerRadius(2)
      .shadow(color: shadowColor, radius: 4, x: 0, y: 0)
      .modifier(
        MoveModifier(
          start: start,
          end:  end,
          progress: animationProgress,
          shouldMove: wasAdded
        )
      )
      .onAppear {
        if wasAdded {
          withAnimation {
            animationProgress = 1
          }
        }
      }
  }
}

#if DEBUG
struct Tile_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Tile(0)
      Tile(2)
      Tile(4)
      Tile(8)
      Tile(16)
      Tile(32)
      Tile(64)
      Tile(128)
      Tile(2048)
    }
    .previewLayout(.fixed(width: 100, height: 100))
  }
}
#endif
