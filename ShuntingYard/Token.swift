//
//  Token.swift
//  ShuntingYard
//
//  Created by Mathias Korsbäck on 2021-03-19.
//

import Foundation

enum ParenType: String {
  case left = "("
  case right = ")"
}

enum Token: Equatable {
  case number(Decimal)
  case op(Operator)
  case paren(ParenType)

  static func > (lhs: Token, rhs: Token) -> Bool {
    switch (lhs, rhs) {
    case (.op(let lhs), .op(let rhs)):
      return lhs > rhs
    default:
      return false
    }
  }

  static func == (lhs: Token, rhs: Token) -> Bool {
    switch (lhs, rhs) {
    case (.op(let lhs), .op(let rhs)):
      return lhs == rhs
    case (.paren(let lhs), .paren(let rhs)):
      return lhs == rhs
    case (.number(let lhs), .number(let rhs)):
      return lhs == rhs
    default:
      return false
    }
  }

}

extension Token: CustomStringConvertible {
  var description: String {
    switch self {
    case .number(let number): return "\(number)"
    case .op(let op): return op.rawValue
    case .paren(let parenType): return parenType.rawValue
    }
  }
}
