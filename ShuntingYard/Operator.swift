//
//  Operator.swift
//  ShuntingYard
//
//  Created by Mathias Korsbäck on 2021-03-19.
//

import Foundation

enum Associativity {
  case left
  case right
}

enum Operator: String, Comparable {
  case add = "+"
  case subtract = "-"
  case multiply = "*"
  case divide = "/"
  case exponent = "^"

  private var precedence: Int {
    switch self {
    case .add, .subtract: return 0
    case .multiply, .divide: return 1
    case .exponent: return 2
    }
  }

  var associativity: Associativity {
    switch self {
    case .exponent: return .right
    default: return .left
    }
  }

  static func < (lhs: Operator, rhs: Operator) -> Bool {
    return lhs.precedence < rhs.precedence
  }

  static func == (lhs: Operator, rhs: Operator) -> Bool {
    return lhs.precedence == rhs.precedence
  }

  func evaluate(lhs: Decimal, rhs: Decimal) -> Decimal {
    switch self {
    case .add:
      return lhs + rhs
    case .subtract:
      return lhs - rhs
    case .multiply:
      return lhs * rhs
    case .divide:
      return lhs / rhs
    case .exponent:
      return pow(lhs, Int(truncating: rhs as NSNumber))
    }
  }
}
