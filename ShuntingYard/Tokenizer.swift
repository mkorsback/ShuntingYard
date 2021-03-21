//
//  Tokenizer.swift
//  ShuntingYard
//
//  Created by Mathias Korsbäck on 2021-03-19.
//

import Foundation

struct Tokenizer {

  static func createInfixTokens(from expression: String) -> [Token] {
    expression
      .map(String.init)
      .reduce(into: [Token]()) { tokens, symbol in
        if let number = Double(symbol) {
          if case let .number(previousSymbol) = tokens.last {
            tokens = tokens.dropLast()
            tokens.append(.number(previousSymbol * 10 + Decimal(number)))
          } else {
            tokens.append(.number(Decimal(number)))
          }
        } else if let op = Operator(rawValue: symbol) {
          tokens.append(.op(op))
        } else if symbol == Token.paren(.left).description {
          tokens.append(Token.paren(.left))
        } else if symbol == Token.paren(.right).description {
          tokens.append(Token.paren(.right))
        }
      }
  }

  /**
   Convert from infix notation to postfix notation using Shunting Yard algorithm.
   */
  static func createPostfixTokens(from infixTokens: [Token]) -> Queue<Token> {
    var outputQueue = Queue<Token>()
    var operatorStack = Stack<Token>()

    for token in infixTokens {
      switch token {
      case .number:
        outputQueue.enqueue(token)
      case .op(let currentOp):
        switch operatorStack.peek() {
        case .none:
          operatorStack.push(Token.op(currentOp))
        case .some:
          while let topOp = operatorStack.peek(),
                (topOp > Token.op(currentOp)) || (topOp == Token.op(currentOp) && currentOp.associativity == .left) {
            outputQueue.enqueue(operatorStack.pop()!)
          }
          operatorStack.push(Token.op(currentOp))
        }
      case .paren(let currentParen):
        if currentParen == .left {
          operatorStack.push(Token.paren(currentParen))
        } else {
          while operatorStack.peek() != .paren(.left) {
            outputQueue.enqueue(operatorStack.pop()!)
          }
          if operatorStack.peek() == .paren(.left) {
            operatorStack.pop()
          }
        }
      }
    }

    while let op = operatorStack.pop() {
      outputQueue.enqueue(op)
    }

    return outputQueue
  }

}
