//
//  QueueTests.swift
//  ShuntingYardTests
//
//  Created by Mathias Korsbäck on 2021-03-19.
//

import XCTest

class QueueTests: XCTestCase {

  func testEmptyQueue() {
    let queue = Queue<Int>()
    XCTAssertTrue(queue.isEmpty)
  }

  func testEnqueueOneElement() {
    var queue = Queue<Int>()
    queue.enqueue(4)
    XCTAssertFalse(queue.isEmpty)
  }

  func testEnqueueAndDequeueOneElement() {
    var queue = Queue<Int>()
    queue.enqueue(4)
    let expectedResult = 4
    let result = queue.dequeue()
    XCTAssertEqual(expectedResult, result)
  }

  func testEnqueueAndDequeueSeveralElements() {
    var queue = Queue<Int>()
    queue.enqueue(4)
    queue.enqueue(8)
    queue.enqueue(12)
    let expectedResult = 12
    queue.dequeue()
    queue.dequeue()
    let result = queue.dequeue()
    XCTAssertEqual(expectedResult, result)
  }

  func testDequeueEmptyQueue() {
    var queue = Queue<Int>()
    let expectedResult = queue.dequeue()
    XCTAssertNil(expectedResult)
  }

  func testDiscardableDequeue() {
    var queue = Queue<Int>()
    queue.enqueue(123)
    queue.dequeue()
    XCTAssertTrue(queue.isEmpty)
  }

  func testPeek() {
    var queue = Queue<Int>()
    queue.enqueue(4)
    let expectedResult = 4
    let result = queue.peek()
    XCTAssertFalse(queue.isEmpty)
    XCTAssertEqual(expectedResult, result)
  }

  func testDescription() {
    let queue = Queue<Int>([1, 2, 3])
    let expectedResult = "[1, 2, 3]"
    let result = queue.description
    XCTAssertEqual(expectedResult, result)
  }
}
