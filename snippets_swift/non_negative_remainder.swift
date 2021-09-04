// snippet_id: 26afc4b1-71dd-4b0e-9e8c-5c17fbbb2896
infix operator %%: MultiplicationPrecedence

func %% (lhs: Int, rhs: Int) -> Int {
    let n = lhs % rhs
    return n >= 0 ? n : n + rhs
}

func testNonnegativeRemainder() {
    assert((-9) %% 3 == 0)
    assert((-8) %% 3 == 1)
    assert((-7) %% 3 == 2)
    assert((-6) %% 3 == 0)
    assert((-5) %% 3 == 1)
    assert((-4) %% 3 == 2)
    assert((-3) %% 3 == 0)
    assert((-2) %% 3 == 1)
    assert((-1) %% 3 == 2)
    assert(0 %% 3 == 0)
    assert(1 %% 3 == 1)
    assert(2 %% 3 == 2)
    assert(3 %% 3 == 0)
    assert(4 %% 3 == 1)
    assert(5 %% 3 == 2)
    assert(6 %% 3 == 0)
    assert(7 %% 3 == 1)
    assert(8 %% 3 == 2)
    assert(9 %% 3 == 0)
}

testNonnegativeRemainder()
