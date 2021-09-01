extension Int {
    /// ```
    /// assert(1.primeFactors() == [:])
    /// assert(12.primeFactors() == [2: 2, 3: 1])
    /// assert(60.primeFactors() == [2: 2, 3: 1, 5: 1])
    /// ```
    func primeFactors() -> [Int: Int] {
        precondition(self >= 1)
        var result = [Int: Int]()
        var n = self
        var i = 2
        while i * i <= n {
            if n % i == 0 {
                var count = 0
                while n % i == 0 {
                    n /= i
                    count += 1
                }
                result[i] = count
            }
            i += 1
        }
        if n > 1 {
            result[n] = 1
        }
        return result
    }
}

func testPrimeFactors() {
    assert(1.primeFactors() == [:])
    assert(2.primeFactors() == [2: 1])
    assert(3.primeFactors() == [3: 1])
    assert(4.primeFactors() == [2: 2])
    assert(5.primeFactors() == [5: 1])
    assert(6.primeFactors() == [2: 1, 3: 1])
    assert(7.primeFactors() == [7: 1])
    assert(8.primeFactors() == [2: 3])
    assert(9.primeFactors() == [3: 2])
    assert(10.primeFactors() == [2: 1, 5: 1])
    assert(11.primeFactors() == [11: 1])
    assert(12.primeFactors() == [2: 2, 3: 1])
    assert(36.primeFactors() == [2: 2, 3: 2])
    assert(60.primeFactors() == [2: 2, 3: 1, 5: 1])
}

testPrimeFactors()
