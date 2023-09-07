//
//  MatrixExtensionTests.swift
//  Composable2048Tests
//
//  Created by Tornike on 08/09/2023.
//

import Foundation
import XCTest
@testable import Composable2048

class MatrixExtensionTests: XCTestCase {
  // Test case for equal matrices
  func testEqualMatrices() {
    let matrix1 = Matrix(rows: 2, columns: 2, repeatedValue: 1)
    let matrix2 = Matrix(rows: 2, columns: 2, repeatedValue: 1)

    XCTAssertTrue(matrix1 == matrix2, "Expected matrices to be equal")
  }

  // Test case for matrices with different dimensions
  func testMatricesWithDifferentDimensions() {
    let matrix1 = Matrix(rows: 2, columns: 2, repeatedValue: 1)
    let matrix2 = Matrix(rows: 3, columns: 2, repeatedValue: 1)

    XCTAssertFalse(matrix1 == matrix2, "Expected matrices to be unequal due to different dimensions")
  }

  // Test case for matrices with different elements
  func testMatricesWithDifferentElements() {
    let matrix1 = Matrix(rows: 2, columns: 2, repeatedValue: 1)
    let matrix2 = Matrix(rows: 2, columns: 2, repeatedValue: 2)

    XCTAssertFalse(matrix1 == matrix2, "Expected matrices to be unequal due to different elements")
  }

  // Test case for matrices with varying dimensions but same elements
  func testMatricesWithVaryingDimensionsAndSameElements() {
    let matrix1 = Matrix(rows: 2, columns: 3, repeatedValue: 1)
    let matrix2 = Matrix(rows: 3, columns: 2, repeatedValue: 1)

    XCTAssertFalse(matrix1 == matrix2, "Expected matrices to be unequal due to varying dimensions")
  }

  // Optional: Test case for identity matrices
  func testIdentityMatrices() {
    let matrix1 = Matrix.identity(size: 3)
    let matrix2 = Matrix.identity(size: 3)

    XCTAssertTrue(matrix1 == matrix2, "Expected identity matrices to be equal")
  }

  // Optional: Test case for zero matrices
  func testZeroMatrices() {
    let matrix1 = Matrix.zeros(rows: 3, columns: 3)
    let matrix2 = Matrix.zeros(rows: 3, columns: 3)

    XCTAssertTrue(matrix1 == matrix2, "Expected zero matrices to be equal")
  }

  // Test to combine values
  func testCanCombineValues() {
    let matrixWithZeros = Matrix.ones(rows: 2, columns: 2)
    XCTAssertTrue(matrixWithZeros.canCombineValues)
  }

  // Test that it is combinable at certain point
  func testCanCombineItemAt() {
    let matrix = Matrix.ones(rows: 5, columns: 5)
    XCTAssertTrue(matrix.canCombineItemAt(row: 0, column: 0))
    XCTAssertTrue(matrix.canCombineItemAt(row: 1, column: 1))
  }
}

