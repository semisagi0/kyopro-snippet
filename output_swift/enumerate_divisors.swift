extension Int {
    /// ```
    /// assert(12.divisors() == [1, 2, 3, 4, 6, 12])
    /// ```
    func divisors() -> [Int] {
        precondition(self >= 1)
        var i = 1
        var result = [Int]()
        while i * i <= self {
            if self % i == 0 {
                result.append(i)
                if i * i != self {
                    result.append(self / i)
                }
            }
            i += 1
        }
        return result.sorted()
    }
}

func testDivisors() {
    assert(1.divisors() == [1])
    assert(2.divisors() == [1, 2])
    assert(3.divisors() == [1, 3])
    assert(4.divisors() == [1, 2, 4])
    assert(5.divisors() == [1, 5])
    assert(6.divisors() == [1, 2, 3, 6])
    assert(7.divisors() == [1, 7])
    assert(8.divisors() == [1, 2, 4, 8])
    assert(9.divisors() == [1, 3, 9])
    assert(10.divisors() == [1, 2, 5, 10])
    assert(11.divisors() == [1, 11])
    assert(12.divisors() == [1, 2, 3, 4, 6, 12])
    assert(16.divisors() == [1, 2, 4, 8, 16])
}

testDivisors()
