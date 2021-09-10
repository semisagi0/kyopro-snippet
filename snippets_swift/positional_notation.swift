// snippet_id: c3cdf631-5bd3-4eaa-823b-4743725b964f
// https://github.com/semisagi0/kyopro-snippet
extension Int {
    func positionalNotation(base: Int) -> [Int] {
        var result: [Int] = []
        var n = self
        while n > 0 {
            result.append(n % base)
            n /= base
        }
        return result
    }
}

func testPositionalNotation() {
    assert(0.positionalNotation(base: 2) == [])
    assert(1.positionalNotation(base: 2) == [1])
    assert(2.positionalNotation(base: 2) == [0, 1])
    assert(3.positionalNotation(base: 2) == [1, 1])
    assert(4.positionalNotation(base: 2) == [0, 0, 1])
    assert(0.positionalNotation(base: 3) == [])
    assert(1.positionalNotation(base: 3) == [1])
    assert(2.positionalNotation(base: 3) == [2])
    assert(3.positionalNotation(base: 3) == [0, 1])
    assert(4.positionalNotation(base: 3) == [1, 1])
    assert(5.positionalNotation(base: 3) == [2, 1])
    assert(6.positionalNotation(base: 3) == [0, 2])
}

testPositionalNotation()
