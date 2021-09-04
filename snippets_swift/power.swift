// snippet_id: 2b93f6b6-6891-4e09-b83b-a4b31ce771c2
precedencegroup PowerPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: right
}

infix operator **: PowerPrecedence

func ** (lhs: Int, rhs: Int) -> Int {
    rhs == 0 ? 1 : lhs * lhs ** (rhs - 1)
}