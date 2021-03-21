//
//  Stack.swift
//  ShuntingYard
//
//  Created by Mathias Korsbäck on 2021-03-18.
//

import Foundation

struct Stack<Element> {

  private var elements = [Element]()

  var isEmpty: Bool {
    peek() == nil
  }

  func peek() -> Element? {
    elements.last
  }

  mutating func push(_ element: Element) {
    elements.append(element)
  }

  @discardableResult
  mutating func pop() -> Element? {
    elements.popLast()
  }

}
