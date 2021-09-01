precedencegroup PowerPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: right
}

infix operator **: PowerPrecedence

func ** (lhs: Int, rhs: Int) -> Int {
    rhs == 0 ? 1 : lhs * lhs ** (rhs - 1)
}