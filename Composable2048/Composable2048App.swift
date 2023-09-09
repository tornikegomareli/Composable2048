//
//  Composable2048App.swift
//  Composable2048
//
//  Created by Tornike on 06/09/2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct Composable2048App: App {
  var body: some Scene {
    MainActor.assumeIsolated {
      WindowGroup {
        MainGameView(
          store: Store(
            initialState: MainGameFeature.State(),
            reducer: {
              MainGameFeature()
                ._printChanges()
            }
          )
        )
      }
    }
  }
}
