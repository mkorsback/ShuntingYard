//
//  Queue.swift
//  ShuntingYard
//
//  Created by Mathias Korsbäck on 2021-03-19.
//

import Foundation

struct Queue<T: Equatable>: Sequence {

  private var storage = [T]()

  var isEmpty: Bool {
    storage.isEmpty
  }

  mutating func enqueue(_ element: T) {
    storage.append(element)
  }

  @discardableResult mutating func dequeue() -> T? {
    guard !storage.isEmpty else { return nil }
    return storage.removeFirst()
  }

  func peek() -> T? {
    storage.first
  }

  init() {
    self.init([])
  }

  init<S: Sequence>(_ sequence: S) where S.Element == Element {
    storage = .init(sequence)
  }

}

extension Queue: IteratorProtocol {
  mutating func next() -> T? {
    self.dequeue()
  }
}

extension Queue: Equatable {
  static func == (lhs: Queue<T>, rhs: Queue<T>) -> Bool {
    lhs.storage == rhs.storage
  }
}

extension Queue: CustomStringConvertible {
  var description: String {
    storage.description
  }
}
