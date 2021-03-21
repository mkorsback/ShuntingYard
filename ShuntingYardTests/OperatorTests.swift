//
//  OperatorTests.swift
//  ShuntingYardTests
//
//  Created by Mathias Korsbäck on 2021-03-19.
//

import XCTest

class OperatorTests: XCTestCase {

  func testPrecedenceBetweenSameOperator() {
    let op1 = Operator.add
    let op2 = Operator.add
    XCTAssertFalse(op1 < op2)
  }

  func testPrecedenceBetweenDifferentOperatorWithSamePrecedence() {
    let op1 = Operator.add
    let op2 = Operator.subtract
    XCTAssertFalse(op1 < op2)
  }

  func testPrecedenceBetweenOperatorWithDifferentPrecedence() {
    let op1 = Operator.add
    let op2 = Operator.multiply
    XCTAssertTrue(op1 < op2)
  }

  func testCompareOperator() {
    let op1 = Operator.add
    let op2 = Operator.add
    XCTAssertTrue(op1 == op2)
  }

  func testCreateExponentOperator() {
    let op = Operator(rawValue: "^")
    XCTAssertEqual(op, Operator.exponent)
  }

  func testEvaluateAddition() {
    let expectedResult: Decimal = 17
    let result = Operator.add.evaluate(lhs: 8, rhs: 9)
    XCTAssertEqual(expectedResult, result)
  }

  func testEvaluateSubtraction() {
    let expectedResult: Decimal = -1
    let result = Operator.subtract.evaluate(lhs: 8, rhs: 9)
    XCTAssertEqual(expectedResult, result)
  }

  func testEvaluateMultiplication() {
    let expectedResult: Decimal = 63
    let result = Operator.multiply.evaluate(lhs: 7, rhs: 9)
    XCTAssertEqual(expectedResult, result)
  }

  func testEvaluateDivision() {
    let expectedResult: Decimal = 12
    let result = Operator.divide.evaluate(lhs: 144, rhs: 12)
    XCTAssertEqual(expectedResult, result)
  }

  func testEvaluateExponent() {
    let expectedResult: Decimal = 64
    let result = Operator.exponent.evaluate(lhs: 8, rhs: 2)
    XCTAssertEqual(expectedResult, result)
  }

}
