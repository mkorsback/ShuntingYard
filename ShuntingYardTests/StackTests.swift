//
//  StackTests.swift
//  ShuntingYardTests
//
//  Created by Mathias Korsbäck on 2021-03-18.
//

import XCTest
@testable import ShuntingYard

class StackTests: XCTestCase {

  func testNewStackShouldBeEmpty() throws {
    let stack = Stack<Int>()
    XCTAssertTrue(stack.isEmpty)
  }

  func testPushOneElementAndStackShouldNotBeEmpty() {
    var stack = Stack<Int>()
    stack.push(4)
    XCTAssertFalse(stack.isEmpty)
  }

  func testPushIntShouldPeekSameInt() {
    var stack = Stack<Int>()
    stack.push(6)
    XCTAssertEqual(6, stack.peek())
  }

  func testPopShouldReturnWhatWasPushed() {
    var stack = Stack<Int>()
    stack.push(4)
    let expectedResult = 4
    let result = stack.pop()
    XCTAssertTrue(stack.isEmpty)
    XCTAssertEqual(expectedResult, result)
  }

  func testStackWithSeveralElementsPushedShouldPopLastOne() {
    var stack = Stack<String>()
    stack.push("This")
    stack.push("is")
    stack.push("a")
    stack.push("test")
    let expectedResult = "test"
    let result = stack.pop()
    XCTAssertEqual(expectedResult, result)
  }

  func testPopValueShouldBeDiscardable() {
    var stack = Stack<Int>()
    stack.push(3)
    stack.pop()
    XCTAssertTrue(stack.isEmpty)
  }
}
