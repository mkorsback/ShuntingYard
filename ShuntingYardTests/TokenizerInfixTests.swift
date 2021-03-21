//
//  TokenizerInfixTests.swift
//  ShuntingYardTests
//
//  Created by Mathias Korsbäck on 2021-03-20.
//

import XCTest

class TokenizerInfixTests: XCTestCase {

  func testShouldReturnEmptyArrayOnEmptyExpression() {
    let expression = ""
    let expectedResult: [Token] = []
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedResult, result)
  }

  func testShouldReturnSingleNumberToken() {
    let expression = "1"
    let expectedResult = [Token.number(1)]
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedResult, result)
  }

  func testShouldHandleMultipleDigitNumber() {
    let expression = "1234"
    let expectedResult = [Token.number(1234)]
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedResult, result)
  }

  func testShouldHandleAddition() {
    let expression = "1 + 2"
    let expectedResult = [
      Token.number(1),
      Token.op(.add),
      Token.number(2),
    ]
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedResult, result)
  }

  func testShouldHandleSubtraction() {
    let expression = "1 - 2"
    let expectedResult = [
      Token.number(1),
      Token.op(.subtract),
      Token.number(2),
    ]
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedResult, result)
  }

  func testShouldHandleMultiplication() {
    let expression = "1 * 2"
    let expectedResult = [
      Token.number(1),
      Token.op(.multiply),
      Token.number(2),
    ]
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedResult, result)
  }

  func testShouldHandleDivision() {
    let expression = "1 / 2"
    let expectedResult = [
      Token.number(1),
      Token.op(.divide),
      Token.number(2),
    ]
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedResult, result)
  }

  func testShouldHandleMultpipleOperators() {
    let expression = "1 + 2 - 3 * 4 / 5"
    let expectedResult = [
      Token.number(1),
      Token.op(.add),
      Token.number(2),
      Token.op(.subtract),
      Token.number(3),
      Token.op(.multiply),
      Token.number(4),
      Token.op(.divide),
      Token.number(5),
    ]
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedResult, result)
  }

  func testOnlyParens() {
    let expression = "()"
    let expectedTokens = [
      Token.paren(.left),
      Token.paren(.right),
    ]
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedTokens, result)
  }

  func testExpressionWithParens() {
    let expression = "(4 + 3)"
    let expectedTokens = [
      Token.paren(.left),
      Token.number(4),
      Token.op(Operator.add),
      Token.number(3),
      Token.paren(.right),
    ]
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedTokens, result)
  }

  func testExpressionWithMultipleLevelsOfParens() {
    let expression = "1 * (4 * 3 - (45 * (6 / 5)) * 3)"
    let expectedTokens = [
      Token.number(1),
      Token.op(Operator.multiply),
      Token.paren(.left),
      Token.number(4),
      Token.op(Operator.multiply),
      Token.number(3),
      Token.op(.subtract),
      Token.paren(.left),
      Token.number(45),
      Token.op(.multiply),
      Token.paren(.left),
      Token.number(6),
      Token.op(.divide),
      Token.number(5),
      Token.paren(.right),
      Token.paren(.right),
      Token.op(.multiply),
      Token.number(3),
      Token.paren(.right),
    ]
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedTokens, result)
  }

  func testShouldHandleExponent() {
    let expression = "1 ^ 2"
    let expectedResult = [
      Token.number(1),
      Token.op(.exponent),
      Token.number(2),
    ]
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedResult, result)
  }

  func testShouldHandleExponentWithOtherOperators() {
    let expression = "9 * 3 ^ 3"
    let expectedResult = [
      Token.number(9),
      Token.op(.multiply),
      Token.number(3),
      Token.op(.exponent),
      Token.number(3),
    ]
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedResult, result)
  }

  func testParensWithExponent() {
    let expression = "(2 + 2) ^ 2"
    let expectedResult = [
      Token.paren(.left),
      Token.number(2),
      Token.op(.add),
      Token.number(2),
      Token.paren(.right),
      Token.op(.exponent),
      Token.number(2),
    ]
    let result = Tokenizer.createInfixTokens(from: expression)
    XCTAssertEqual(expectedResult, result)
  }
}
