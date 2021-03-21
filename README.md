# Swift implementation of the Shunting Yard algorithm.

This is a small example if how to use the shunting yard algorithm to convert expressions written using [infix notation](https://en.wikipedia.org/wiki/Infix_notation) to [postfix notation](https://en.wikipedia.org/wiki/Reverse_Polish_notation) (aka Reverse Polish Notation, or RPN).

More information here:
[https://en.wikipedia.org/wiki/Shunting-yard_algorithm](https://en.wikipedia.org/wiki/Shunting-yard_algorithm)

Example of infix to postfix:
> Infix: 2 / 8 - 3 * (15 / 5) ^ 3  
> Postfix: 2, 8, /, 3, 15, 5, /, 3, ^, *, -  

The project also contains an evaluator that performs evaluation of the expression.

Example run:
> Expression: 2 / 8 - 3 * (15 / 5) ^ 3  
> Infix tokens: [2, /, 8, -, 3, *, (, 15, /, 5, ), ^, 3]  
> Postfix tokens: [2, 8, /, 3, 15, 5, /, 3, ^, *, -]  
> Result: -80.75  

## Technical details
Implemented using a Stack and a Queue to stay close to the original algorithm.

100% test coverage because why not. 😎

### PEMDAS Support
- [x] Parentheses
- [x] Exponents
- [x] Multiplication
- [x] Division
- [x] Addition
- [x] Subtraction


### Current known limitations
- Only handles integers as input
- No support for unary operations
- Doesn't handle non-integer exponents, like `9 ^ (2 / 6)`
- Error handling is minimal at best

PR:s are more than welcome.

