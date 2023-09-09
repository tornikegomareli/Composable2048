//
//  GoalText.swift
//  Composable2048
//
//  Created by Tornike on 10/09/2023.
//

import Foundation
import SwiftUI

struct GoalText: View {
  let goal = "2048"
  var body: some View {
    HStack (alignment: .center, spacing: 4) {
      Text("Join the numbers and get to the")
      Text("\(goal) tile!") .bold()
    }
    .font(.system(size: 16, weight: .regular, design: .rounded))
    .foregroundColor(.white40)
  }
}

struct GoalText_Previews: PreviewProvider {
  static var previews: some View {
    GoalText()
  }
}
