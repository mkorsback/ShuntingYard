//
//  main.swift
//  ShuntingYard
//
//  Created by Mathias Korsbäck on 2021-03-18.
//

import Foundation

print("Expression: ", terminator: "")

while let expression = readLine(), !expression.isEmpty {
  let infixTokens = Tokenizer.createInfixTokens(from: expression)
  print("Infix tokens: \(infixTokens)")
  let postfixTokens = Tokenizer.createPostfixTokens(from: infixTokens)
  print("Postfix tokens: \(postfixTokens)")
  let result = Evaluator.evaluate(postfixTokens)!
  print("Result: \(result)\n")

  print("Expression: ", terminator: "")
}
