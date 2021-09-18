// snippet_id: cec18690-8918-4c62-99f0-1a8df48d9a43
// https://github.com/semisagi0/kyopro-snippet
infix operator /+: MultiplicationPrecedence // 切り上げ

// ceil(lhs/rhs)と等価。
func /+ (lhs: Int, rhs: Int) -> Int {
    if rhs < 0 {
        return -lhs /+ -rhs
    }
    return lhs >= 0 ? (lhs + rhs - 1) / rhs : lhs / rhs
}

func testCeilingDivision() {
    assert(0 /+ 3 == 0)
    assert(5 /+ 2 == 3)
    assert(6 /+ 2 == 3)
    assert(-3 /+ 2 == -1)
    assert(-4 /+ 2 == -2)

    assert(0 /+ -3 == 0)
    assert(-5 /+ -2 == 3)
    assert(-6 /+ -2 == 3)
    assert(3 /+ -2 == -1)
    assert(4 /+ -2 == -2)
}

testCeilingDivision()
