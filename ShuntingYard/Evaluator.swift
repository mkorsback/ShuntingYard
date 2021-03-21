//
//  Evaluator.swift
//  ShuntingYard
//
//  Created by Mathias Korsbäck on 2021-03-19.
//

import Foundation

struct Evaluator {

  static func evaluate(_ queue: Queue<Token>) -> Decimal? {
    var stack = Stack<Decimal>()

    for token in queue {
      switch token {
      case .number(let number): stack.push(number)
      case .op(let op):
        if let rhs = stack.pop(), let lhs = stack.pop() {
          let result = op.evaluate(lhs: lhs, rhs: rhs)
          stack.push(result)
        }
      default: break
      }
    }

    return stack.pop()
  }

}
