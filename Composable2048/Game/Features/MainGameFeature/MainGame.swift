//
//  MainGame.swift
//  Composable2048
//
//  Created by Tornike on 10/09/2023.
//

import SwiftUI
import ComposableArchitecture

struct MainGameFeature: Reducer {
  struct State: Equatable {
    static func == (lhs: MainGameFeature.State, rhs: MainGameFeature.State) -> Bool {
      return lhs.board.isEqual(rhs.board)
    }

    var board: Matrix = .zeros(rows: 4, columns: 4)
    var movements: [TileMovement] = []
    var newTile: (Int, Int)?
    var isUndoEnabled: Bool = true
    var score: Int = 0
  }

  enum Action {
    case start
    case userSwipedWith(direction: GameEngine.Direction)
    case addTale
    case updateBestScore(score: Int)
  }

  var body: some ReducerOf<Self> {
    @Dependency(\.gameEngine) var engine
    Reduce { state, action in
      switch  action {
      case .start:
        let (updatedBoard, addedTile) = engine.addNumber(state.board)
        state.board = updatedBoard
        state.newTile = addedTile
        return .none
      case .addTale:
        let (updatedBoard, addedTile) = engine.addNumber(state.board)
        state.board = updatedBoard
        state.newTile = addedTile
        return .none
      case .userSwipedWith(let direction):
        let (updatedBoard, movements, updatedScore) = engine.push(state.board, to: direction)
        state.board = updatedBoard
        state.score += updatedScore
        state.movements = movements
        let latestGameScore = state.score
        return .run { send in
          await send(.addTale)
          await send(.updateBestScore(score: latestGameScore))
        }
      case .updateBestScore(let score):
//        let gameState = GameState(bestScore: max(state.gameState.first?.bestScore ?? 0, score))
//        state.modelContext.insert(gameState)
        return .none
      }
    }
  }
}

struct MainGameView: View {
  let store: StoreOf<MainGameFeature>
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack(alignment: .center, spacing: 16) {
        Header(
          score: viewStore.score, bestScore: 0,
          menuAction: {
            print("Menu Action")
          },
          undoAction: {
            print("Undo Action")
          },
          undoEnabled: viewStore.isUndoEnabled
        )

        GoalText()
        Board(board: viewStore.state.board, movements: viewStore.state.movements)
          .gesture(
            DragGesture(
              minimumDistance: 20,
              coordinateSpace: .global
            )
            .onEnded { value in
              let horizontalAmount = value.translation.width
              let verticalAmount = value.translation.height

              if let direction = detectSwipeDirection(horizontalAmount, verticalAmount) {
                viewStore.send(.userSwipedWith(direction: direction))
              }
            }
          )
        Moves(0)
      }
      .frame(minWidth: .zero,
             maxWidth: .infinity,
             minHeight: .zero,
             maxHeight: .infinity,
             alignment: .center)
      .background(Color.gameBackground)
      //.background(Menu())
      //.background(GameOver())
      .edgesIgnoringSafeArea(.all)
      .onAppear {
        viewStore.send(.start)
      }
    }
  }
}

#Preview {
  MainActor.assumeIsolated {
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
