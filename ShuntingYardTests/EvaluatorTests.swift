//
//  EvaluatorTests.swift
//  ShuntingYardTests
//
//  Created by Mathias Korsbäck on 2021-03-19.
//

import XCTest

class EvaluatorTests: XCTestCase {

  func testSingleNumberTokenShouldReturnSameNumber() {
    let infixTokens = Tokenizer.createInfixTokens(from: "1")
    let postfixTokens = Tokenizer.createPostfixTokens(from: infixTokens)
    let expectedResult: Decimal = 1
    let result = Evaluator.evaluate(postfixTokens)
    XCTAssertEqual(expectedResult, result)
  }

  func testAddTwoNumbers() {
    let infixTokens = Tokenizer.createInfixTokens(from: "1 + 2")
    let postfixTokens = Tokenizer.createPostfixTokens(from: infixTokens)
    let expectedResult: Decimal = 3
    let result = Evaluator.evaluate(postfixTokens)
    XCTAssertEqual(expectedResult, result)
  }

  func testExpressionUsingAddAndSubtract() {
    let infixTokens = Tokenizer.createInfixTokens(from: "1 + 2 + 4 - 3")
    let postfixTokens = Tokenizer.createPostfixTokens(from: infixTokens)
    let expectedResult: Decimal = 4
    let result = Evaluator.evaluate(postfixTokens)
    XCTAssertEqual(expectedResult, result)
  }

  func testExpressionUsingAddSubtractMultiply() {
    let infixTokens = Tokenizer.createInfixTokens(from: "1 + 4 - 4 * 3")
    let postfixTokens = Tokenizer.createPostfixTokens(from: infixTokens)
    let expectedResult: Decimal = -7
    let result = Evaluator.evaluate(postfixTokens)!
    XCTAssertEqual(expectedResult, result)
  }

  func testDivide() {
    let infixTokens = Tokenizer.createInfixTokens(from: "9 / 3")
    let postfixTokens = Tokenizer.createPostfixTokens(from: infixTokens)
    let expectedResult: Decimal = 3
    let result = Evaluator.evaluate(postfixTokens)
    XCTAssertEqual(expectedResult, result)
  }

  func testAllFourOperators() {
    let infixTokens = Tokenizer.createInfixTokens(from: "1 + 2 - 3 * 4 / 5")
    let postfixTokens = Tokenizer.createPostfixTokens(from: infixTokens)
    let expectedResult: Decimal = 0.6
    let result = Evaluator.evaluate(postfixTokens)
    XCTAssertEqual(expectedResult, result)
  }

  func testExponent() {
    let infixTokens = Tokenizer.createInfixTokens(from: "3 * 3 ^ 3")
    let postfixTokens = Tokenizer.createPostfixTokens(from: infixTokens)
    let expectedResult: Decimal = 81
    let result = Evaluator.evaluate(postfixTokens)
    XCTAssertEqual(expectedResult, result)
  }

  func testComplexExpression() {
    let infixTokens = Tokenizer.createInfixTokens(from: "99 / 11 * 432 ^ (4 - 2)")
    let postfixTokens = Tokenizer.createPostfixTokens(from: infixTokens)
    let expectedResult: Decimal = 1_679_616
    let result = Evaluator.evaluate(postfixTokens)
    XCTAssertEqual(expectedResult, result)
  }

  func testSlightlyComplicatedExpression() {
    let infixTokens = Tokenizer.createInfixTokens(from: "4 - 3 * (20 - 3 * 4 - (2 + 2 ^ 2)) / 2")
    let postfixTokens = Tokenizer.createPostfixTokens(from: infixTokens)
    let expectedResult: Decimal = 1
    let result = Evaluator.evaluate(postfixTokens)
    XCTAssertEqual(expectedResult, result)
  }

  func testAnotherSlightlyComplicatedExpression() {
    let infixTokens = Tokenizer.createInfixTokens(from: "((5 - 2) ^ (3 + 1) / (2 + 1) + 12) * 21")
    let postfixTokens = Tokenizer.createPostfixTokens(from: infixTokens)
    let expectedResult: Decimal = 819
    let result = Evaluator.evaluate(postfixTokens)
    XCTAssertEqual(expectedResult, result)
  }

}
