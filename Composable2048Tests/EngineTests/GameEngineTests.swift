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
//
//  func testSlide() {
//    let row = [2, 0, 2, 4]
//    let result = engine.slide(row)
//    XCTAssertEqual(result, [0, 0, 2, 4])
//  }
//
//  func testCombine() {
//    let row = [2, 2, 4, 4]
//    let result = engine.combine(row)
//    XCTAssertEqual(result, [0, 4, 0, 8])
//  }
//
//  func testFlip() {
//    let initialBoard = Matrix([[1, 2], [3, 4]])
//    let flippedBoard = engine.flip(initialBoard)
//    let expectedBoard = Matrix([[2, 1], [4, 3]])
//    //XCTAssertEqual(flippedBoard, expectedBoard)
//  }
//
//  func testRotate() {
//    let initialBoard = Matrix([[1, 2], [3, 4]])
//    let rotatedBoard = engine.rotate(initialBoard)
//    let expectedBoard = Matrix([[1, 3], [2, 4]])
//    //XCTAssertEqual(rotatedBoard, expectedBoard)
//  }
//
//  func testPush() {
//    let initialBoard = Matrix([[2, 2, 0, 4], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]])
//    let (newBoard, scoredPoints) = engine.push(initialBoard, to: .right)
//    let expectedBoard = Matrix([[0, 0, 4, 4], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]])
//    //XCTAssertEqual(newBoard, expectedBoard)
//    //XCTAssertEqual(scoredPoints, 8)
//  }
}
