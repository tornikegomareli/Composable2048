//
//  GameEngineTests.swift
//  Composable2048Tests
//
//  Created by Tornike on 08/09/2023.
//

import Foundation
import XCTest
@testable import Composable2048

class GameEngineTests: XCTestCase {
  var engine: GameEngine!
  var board: Matrix!

  override func setUp() {
    super.setUp()
    engine = GameEngine()
    board = Matrix.zeros(rows: 4, columns: 4)  // Initialize as you find appropriate
  }

  override func tearDown() {
    engine = nil
    board = nil
    super.tearDown()
  }

  func testIsGameOver() {
    let gameOverBoard = [
      [2.0, 4.0, 2.0, 4.0],
      [4.0, 2.0, 4.0, 2.0],
      [2.0, 4.0, 2.0, 4.0],
      [4.0, 2.0, 4.0, 2.0]
    ]

    board = Matrix.init(gameOverBoard)
    XCTAssertTrue(engine.isGameOver(board))

    let notGameOverBoard = [
      [2.0, 4.0, 2.0, 4.0],
      [4.0, 2.0, 4.0, 0.0],
      [2.0, 4.0, 2.0, 4.0],
      [4.0, 2.0, 4.0, 2.0]
    ]

    board = Matrix.init(notGameOverBoard)
    XCTAssertFalse(engine.isGameOver(board))
  }

  /// This tests need to fix and debug, there is some kind of problem in Game Engine
  func testAddNumber() {
    let initialBoard = [
      [2.0, 4.0, 2.0, 4.0],
      [4.0, 0, 4.0, 0],
      [2.0, 4.0, 2.0, 4.0],
      [4.0, 2.0, 4.0, 0]
    ]

    board = Matrix.init(initialBoard)
    let (newBoard, addedTile) = engine.addNumber(board)
    print("OLD BOARD")
    print(board.debugDescription)
    print("_______________-")
    print(newBoard.debugDescription)
    XCTAssertNotEqual(board, newBoard)
    XCTAssertNotNil(addedTile)
  }

  func testWhenTryingAddNumberOnFullBoard() {
    let initialBoard = [
      [2.0, 4.0, 2.0, 4.0],
      [4.0, 2.0, 4.0, 2.0],
      [2.0, 4.0, 2.0, 4.0],
      [4.0, 2.0, 4.0, 2.0]
    ]

    board = Matrix.init(initialBoard)
    let (newBoard, addedTile) = engine.addNumber(board)

    print(newBoard.debugDescription)
    XCTAssertNil(addedTile, "Added tile need to be nil, cause board is full")
  }

  func testSlide() {
    let row = [2, 0, 4, 0]
    let result = engine.slide(row)
    XCTAssertEqual(result, [0, 0, 2, 4])
  }

  func testCombine() {
    let row = [2, 2, 4, 4]
    let result = engine.combine(row)
    XCTAssertEqual(result, [0, 4, 0, 8])
  }

  func testFlip() {
    let initialBoard = Matrix(
      [
        [1, 2, 3, 4],
        [4, 5, 6, 7],
        [8, 9, 10, 11],
        [15, 15, 15, 15]
      ]
    )

    let flippedBoard = engine.flip(initialBoard)
    print(flippedBoard.debugDescription)
    let expectedBoard = Matrix([
      [4.0, 3.0, 2.0, 1.0],
      [7.0, 6.0, 5.0, 4.0],
      [11.0, 10.0, 9.0, 8.0],
      [15.0, 15.0, 15.0, 15.0]
    ])

    XCTAssertEqual(flippedBoard, expectedBoard)
  }

  func testRotateCounterClockWise() {
    let initialBoard = Matrix([
        [512.0, 16.0, 0.0, 64.0],
        [2048.0, 512.0, 2.0, 64.0],
        [1024.0, 32.0, 128.0, 32.0],
        [64.0, 2.0, 2048.0, 16.0]
    ])

    let rotatedBoard = engine.rotate(initialBoard)

    print(rotatedBoard.debugDescription)

    let expectedBoard = Matrix([
      [64.0, 64.0, 32.0, 16.0],
      [0.0, 2.0, 128.0, 2048.0],
      [16.0, 512.0, 32.0, 2.0],
      [512.0, 2048.0, 1024.0, 64.0]
    ])
    XCTAssertEqual(rotatedBoard, expectedBoard)
  }

  func testPush() {
    let initialBoard = Matrix(
      [
        [2, 2, 0, 4],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ]
    )
    let (newBoard, scoredPoints) = engine.push(initialBoard, to: .right)
    let expectedBoard = Matrix(
      [
        [0, 0, 4, 4],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ]
    )
    XCTAssertEqual(newBoard, expectedBoard)
    XCTAssertEqual(scoredPoints, 4)

    print(newBoard.debugDescription)
    let (updatedBoard, newScoredPoints) = engine.push(newBoard, to: .right)
    print(updatedBoard.debugDescription)
    let newExpectedBoard = Matrix(
      [
        [0, 0, 0, 8],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ]
    )

    XCTAssertEqual(updatedBoard, newExpectedBoard)
    XCTAssertEqual(newScoredPoints, 8)
  }

  // Test pushing to the right
  func testPushRight() {
    let initialBoard = Matrix([
      [2.0, 0.0, 2.0, 4.0],
      [4.0, 4.0, 4.0, 0.0],
      [2.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0]
    ])

    let (newBoard, scoredPoints) = engine.push(initialBoard, to: .right)
    print(newBoard.debugDescription)
    // Your assertions here
    // For example:
    XCTAssertEqual(
      newBoard[row: 0],
      [0.0, 0.0, 4.0, 4.0]
    )
    XCTAssertEqual(
      newBoard[row: 1],
      [0.0, 0.0, 4.0, 8.0]
    )

    XCTAssertEqual(
      newBoard[row: 2],
      [0.0, 0.0, 0.0, 2.0]
    )

    XCTAssertEqual(scoredPoints, 12)
  }

  // Test pushing up
  func testPushUp() {
    let initialBoard = Matrix([
      [2.0, 0.0, 2.0, 0.0],
      [0.0, 4.0, 0.0, 0.0],
      [0.0, 4.0, 4.0, 8.0],
      [0.0, 0.0, 0.0, 8.0]
    ])

    let (newBoard, scoredPoints) = engine.push(initialBoard, to: .up)

    let expectedBoard = Matrix([
      [2.0, 8.0, 2.0, 16.0],
      [0.0, 0.0, 4.0, 0.0],
      [0.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0]
    ])

    XCTAssertEqual(expectedBoard, newBoard)
    XCTAssertEqual(scoredPoints, 24)
  }

  // Test pushing left
  func testPushLeft() {
    let initialBoard = Matrix([
      [2.0, 0.0, 2.0, 4.0],
      [4.0, 4.0, 4.0, 0.0],
      [2.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0]
    ])

    let (newBoard, scoredPoints) = engine.push(initialBoard, to: .left)
    XCTAssertEqual(newBoard[row: 0], [4.0, 4.0, 0.0, 0.0])
    XCTAssertEqual(newBoard[row: 1], [8.0, 4.0, 0.0, 0.0])
    XCTAssertEqual(newBoard[row: 2], [2.0, 0.0, 0.0, 0.0])
    XCTAssertEqual(scoredPoints, 12)
  }

  // Test pushing down
  func testPushDown() {
    let initialBoard = Matrix([
      [2.0, 0.0, 2.0, 4.0],
      [4.0, 4.0, 0.0, 0.0],
      [2.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0]
    ])

    let (newBoard, scoredPoints) = engine.push(initialBoard, to: .down)

    print(newBoard.debugDescription)
    XCTAssertEqual(newBoard[row: 0], [0.0, 0.0, 0.0, 0.0])
    XCTAssertEqual(newBoard[row: 1], [2.0, 0.0, 0.0, 0.0])
    XCTAssertEqual(newBoard[row: 2], [4.0, 0.0, 0.0, 0.0])
    XCTAssertEqual(newBoard[row: 3], [2.0, 4.0, 2.0, 4.0])

    XCTAssertEqual(scoredPoints, 0)
  }
}
