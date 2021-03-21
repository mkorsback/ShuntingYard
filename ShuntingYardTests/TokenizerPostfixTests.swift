//
//  TokenizerPostfixTests.swift
//  ShuntingYardTests
//
//  Created by Mathias Korsbäck on 2021-03-19.
//

import XCTest

class TokenizerPostfixTests: XCTestCase {

  func testShouldReturnEmptyArrayOnEmptyInput() {
    let infixTokens: [Token] = []
    let expectedResult = Queue<Token>()
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedResult, result)
  }

  func testSingleToken() {
    let infixTokens = Tokenizer.createInfixTokens(from: "4")
    let expectedResult = Queue<Token>([
      Token.number(4),
    ])
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedResult, result)
  }

  func testAddition() {
    let infixTokens = Tokenizer.createInfixTokens(from: "4 + 3")
    let expectedResult = Queue<Token>([
      Token.number(4),
      Token.number(3),
      Token.op(Operator.add),
    ])
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedResult, result)
  }

  func testRepeatingAddOperators() {
    let infixTokens = Tokenizer.createInfixTokens(from: "4 + ( 3 + 2 )")
    let expectedResult = Queue<Token>([
      Token.number(4),
      Token.number(3),
      Token.number(2),
      Token.op(Operator.add),
      Token.op(Operator.add),
    ])
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedResult, result)
  }

  func testRepeatingSubtractOperators() {
    let infixTokens = Tokenizer.createInfixTokens(from: "4 - ( 3 - 2 )")
    let expectedResult = Queue<Token>([
      Token.number(4),
      Token.number(3),
      Token.number(2),
      Token.op(Operator.subtract),
      Token.op(Operator.subtract),
    ])
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedResult, result)
  }

  func testMultipleOperators() {
    let infixTokens = Tokenizer.createInfixTokens(from: "4 + 3 - 2")
    let expectedTokens = Queue<Token>([
      Token.number(4),
      Token.number(3),
      Token.op(Operator.add),
      Token.number(2),
      Token.op(Operator.subtract),
    ])
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedTokens, result)
  }

  func testMultipleOperatorsWithDifferentPrecedence() {
    let infixTokens = Tokenizer.createInfixTokens(from: "4 + 3 * 2")
    let expectedTokens = Queue<Token>([
      Token.number(4),
      Token.number(3),
      Token.number(2),
      Token.op(Operator.multiply),
      Token.op(Operator.add),
    ])
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedTokens, result)
  }

  func testAllTheOperators() {
    let expression = "1 + 2 - 3 * 4 / 5 + 6 - 7 * 8 / 9 + 8 - 7 * 6 / 5 + 4 - 3 * 2 / 1"
    let infixTokens = Tokenizer.createInfixTokens(from: expression)
    let expectedTokens = Queue<Token>([
      Token.number(1), Token.number(2), Token.op(Operator.add),
      Token.number(3), Token.number(4), Token.op(Operator.multiply),
      Token.number(5), Token.op(Operator.divide), Token.op(Operator.subtract),
      Token.number(6), Token.op(Operator.add),
      Token.number(7), Token.number(8), Token.op(Operator.multiply),
      Token.number(9), Token.op(Operator.divide), Token.op(Operator.subtract),
      Token.number(8), Token.op(Operator.add),
      Token.number(7), Token.number(6), Token.op(Operator.multiply),
      Token.number(5), Token.op(Operator.divide), Token.op(Operator.subtract),
      Token.number(4), Token.op(Operator.add),
      Token.number(3), Token.number(2), Token.op(Operator.multiply),
      Token.number(1), Token.op(Operator.divide), Token.op(Operator.subtract),
    ])
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedTokens, result)
  }

  func testEmptyParensShouldReturnEmptyQueue() {
    let expression = "()"
    let infixTokens = Tokenizer.createInfixTokens(from: expression)
    let expectedTokens = Queue<Token>([])
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedTokens, result)
  }

  func testWithParens() {
    let expression = "(3 + 2) * 4"
    let infixTokens = Tokenizer.createInfixTokens(from: expression)
    let expectedTokens = Queue<Token>([
      Token.number(3),
      Token.number(2),
      Token.op(Operator.add),
      Token.number(4),
      Token.op(Operator.multiply),
    ])
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedTokens, result)
  }

  func testWithMoreParens() {
    let expression = "4 * (3 * (8 / 2))"
    let infixTokens = Tokenizer.createInfixTokens(from: expression)
    let expectedTokens = Queue<Token>([
      Token.number(4),
      Token.number(3),
      Token.number(8),
      Token.number(2),
      Token.op(Operator.divide),
      Token.op(Operator.multiply),
      Token.op(Operator.multiply),
    ])
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedTokens, result)
  }

  func testWithAllTheParens() {
    let expression = "1 * (4 * 3 - 45 * (6 / 5) * 3)"
    let infixTokens = Tokenizer.createInfixTokens(from: expression)
    let expectedTokens = Queue<Token>([
      Token.number(1),
      Token.number(4),
      Token.number(3),
      Token.op(Operator.multiply),
      Token.number(45),
      Token.number(6),
      Token.number(5),
      Token.op(Operator.divide),
      Token.op(Operator.multiply),
      Token.number(3),
      Token.op(Operator.multiply),
      Token.op(Operator.subtract),
      Token.op(Operator.multiply),
    ])
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedTokens, result)
  }

  func testWithExponent() {
    let expression = "3 * 3 ^ 3"
    let infixTokens = Tokenizer.createInfixTokens(from: expression)
    let expectedTokens = Queue<Token>([
      Token.number(3),
      Token.number(3),
      Token.number(3),
      Token.op(Operator.exponent),
      Token.op(Operator.multiply),
    ])
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedTokens, result)
  }

  func testRepeatingExponents() {
    let expression = "4 ^ 3 ^ 2"
    let infixTokens = Tokenizer.createInfixTokens(from: expression)
    let expectedTokens = Queue<Token>([
      Token.number(4),
      Token.number(3),
      Token.number(2),
      Token.op(Operator.exponent),
      Token.op(Operator.exponent),
    ])
    let result = Tokenizer.createPostfixTokens(from: infixTokens)
    XCTAssertEqual(expectedTokens, result)
  }

}
