//
//  TokenTests.swift
//  ShuntingYardTests
//
//  Created by Mathias Korsbäck on 2021-03-19.
//

import XCTest

class TokenTests: XCTestCase {

  func testTokenDescriptionForNumber() {
    let token = Token.number(4)
    let expectedResult = "4"
    XCTAssertEqual(expectedResult, token.description)
  }

  func testTokenDescriptionForOperator() {
    let token = Token.op(.add)
    let expectedResult = "+"
    XCTAssertEqual(expectedResult, token.description)
  }

  func testTokenDescriptionForLeftParen() {
    let token = Token.paren(.left)
    let expectedResult = "("
    XCTAssertEqual(expectedResult, token.description)
  }

  func testTokenDescriptionForRightParen() {
    let token = Token.paren(.right)
    let expectedResult = ")"
    XCTAssertEqual(expectedResult, token.description)
  }

  func testAddHasLowerPrecedenceThanMultiply() {
    let token1 = Token.op(.add)
    let token2 = Token.op(.multiply)
    let result = token1 > token2
    XCTAssertNotNil(result)
    XCTAssertFalse(result)
  }

  func testTokenInvalidPrecedenceForNumbers() {
    let token1 = Token.number(4)
    let token2 = Token.number(5)
    let result = token1 > token2
    XCTAssertFalse(result)
  }

  func testTokenInvalidPrecedenceForNumberAndOperator() {
    let token1 = Token.number(4)
    let token2 = Token.op(.add)
    let result = token1 > token2
    XCTAssertFalse(result)
  }

  func testParenEqualsParen() {
    let paren1 = Token.paren(.left)
    let paren2 = Token.paren(.left)
    XCTAssertTrue(paren1 == paren2)
  }
}
