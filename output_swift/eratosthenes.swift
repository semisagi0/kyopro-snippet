func eratosthenes(through n: Int) -> [Bool] {
    precondition(n >= 0)
    if n == 0 {
        return [false]
    }
    if n == 1 {
        return [false, false]
    }
    var table = [Bool](repeating: true, count: n + 1)
    table[0] = false
    table[1] = false
    for i in 2 ... n where table[i] {
        for j in stride(from: i * 2, through: n, by: i) {
            table[j] = false
        }
    }
    return table
}

func testEratosthenes() {
    assert(eratosthenes(through: 0) == [false])
    assert(eratosthenes(through: 1) == [false, false])
    assert(eratosthenes(through: 2) == [false, false, true])
    assert(eratosthenes(through: 3) == [false, false, true, true])
    assert(eratosthenes(through: 4) == [false, false, true, true, false])
    assert(eratosthenes(through: 5) == [false, false, true, true, false, true])
    assert(
        eratosthenes(through: 20) == [
            false, false, true, true, false,
            true, false, true, false, false,
            false, true, false, true, false,
            false, false, true, false, true,
            false
        ]
    )
}

testEratosthenes()
