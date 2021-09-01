infix operator <+>: AdditionPrecedence
infix operator <*>: MultiplicationPrecedence
infix operator <+>=: AssignmentPrecedence
infix operator <*>=: AssignmentPrecedence

func <+> (lhs: Int, rhs: Int) -> Int {
    let (result, overflow) = lhs.addingReportingOverflow(rhs)
    if overflow {
        return Int.max
    }
    return result
}

func <*> (lhs: Int, rhs: Int) -> Int {
    let (result, overflow) = lhs.multipliedReportingOverflow(by: rhs)
    if overflow {
        return Int.max
    }
    return result
}

func <+>= (lhs: inout Int, rhs: Int) {
    lhs = lhs <+> rhs
}

func <*>= (lhs: inout Int, rhs: Int) {
    lhs = lhs <*> rhs
}