//
//  RelativeSizeLayout.swift
//  Composable2048
//
//  Created by Tornike on 08/09/2023.
//

import Foundation
import SwiftUI

/// A custom layout that proposes a percentage of its
/// received proposed size to its subview.
///
/// - Precondition: must contain exactly one subview.
public struct RelativeSizeLayout: Layout {
  var relativeWidth: Double
  var relativeHeight: Double

  public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
    assert(subviews.count == 1, "RelativeSizeLayout expects a single subview")
    let resizedProposal = ProposedViewSize(
      width: proposal.width.map { $0 * relativeWidth },
      height: proposal.height.map { $0 * relativeHeight }
    )
    return subviews[0].sizeThatFits(resizedProposal)
  }

  public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
    assert(subviews.count == 1, "RelativeSizeLayout expects a single subview")
    let resizedProposal = ProposedViewSize(
      width: proposal.width.map { $0 * relativeWidth },
      height: proposal.height.map { $0 * relativeHeight }
    )
    subviews[0].place(at: CGPoint(x: bounds.midX, y: bounds.midY), anchor: .center, proposal: resizedProposal)
  }
}
