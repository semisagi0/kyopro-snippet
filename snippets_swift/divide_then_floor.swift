// snippet_id: 9fade958-2a9a-4341-a735-9162b9cc09c4
infix operator /-: MultiplicationPrecedence // 切り下げ

/// ```
/// assert(5 /- 2 == 2)
/// assert(6 /- 2 == 3)
/// assert(-3 /- 2 == -2)
/// assert(-4 /- 2 == -2)
/// ```
func /- (lhs: Int, rhs: Int) -> Int {
    lhs >= 0 ? lhs / rhs : (lhs - rhs + 1) / rhs
}

func testFloorDivision() {
    assert(0 /- 3 == 0)
    assert(5 /- 2 == 2)
    assert(6 /- 2 == 3)
    assert(-3 /- 2 == -2)
    assert(-4 /- 2 == -2)
}

testFloorDivision()
