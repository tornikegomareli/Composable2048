//
//  View+RelativeSize.swift
//  Composable2048
//
//  Created by Tornike on 06/09/2023.
//

import Foundation
import SwiftUI

extension View {
  /// Proposes a percentage of its received proposed size to `self`.
  ///
  /// This modifier multiplies the proposed size it receives from its parent
  /// with the given factors for width and height.
  ///
  /// If the parent proposes `nil` or `.infinity` to us in any dimension,
  /// we’ll forward these values to our child view unchanged.
  ///
  /// - Note: The size we propose to `self` will not necessarily be a percentage
  ///   of the parent view’s actual size or of the available space as not all
  ///   views propose the full available space to their children. For example,
  ///   VStack and HStack divide the available space among their subviews and
  ///   only propose a fraction to each subview.
  public func relativeProposed(width: Double = 1, height: Double = 1) -> some View {
    RelativeSizeLayout(relativeWidth: width, relativeHeight: height) {
      // Wrap content view in a container to make sure the layout only
      // receives a single subview.
      // See Chris Eidhof, SwiftUI Views are Lists (2023-01-25)
      // <https://chris.eidhof.nl/post/swiftui-views-are-lists/>
      VStack { // alternatively: `_UnaryViewAdaptor(self)`
        self
      }
    }
  }
}
