// snippet_id: 9fade958-2a9a-4341-a735-9162b9cc09c4
// https://github.com/semisagi0/kyopro-snippet
infix operator /-: MultiplicationPrecedence // 切り下げ

// floor(lhs/rhs)と等価。
func /- (lhs: Int, rhs: Int) -> Int {
    if rhs < 0 {
        return -lhs /- -rhs
    }
    return lhs >= 0 ? lhs / rhs : (lhs - rhs + 1) / rhs
}

func testFloorDivision() {
    assert(0 /- 3 == 0)
    assert(5 /- 2 == 2)
    assert(6 /- 2 == 3)
    assert(-3 /- 2 == -2)
    assert(-4 /- 2 == -2)

    assert(0 /- -3 == 0)
    assert(-5 /- -2 == 2)
    assert(-6 /- -2 == 3)
    assert(3 /- -2 == -2)
    assert(4 /- -2 == -2)
}

testFloorDivision()