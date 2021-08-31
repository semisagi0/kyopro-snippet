extension Int {
    /// ```
    /// assert(!1.isPrime())
    /// assert(2.isPrime())
    /// assert(3.isPrime())
    /// assert(!4.isPrime())
    /// assert(5.isPrime())
    /// assert(!6.isPrime())
    /// assert(7.isPrime())
    /// assert(!8.isPrime())
    /// assert(!9.isPrime())
    /// assert(!10.isPrime())
    /// ```
    func isPrime() -> Bool {
        guard self >= 2 else { return false }
        var i = 2
        while i * i <= self {
            if self % i == 0 {
                return false
            }
            i += 1
        }
        return true
    }
}

func testIsPrime() {
    assert(!1.isPrime())
    assert(2.isPrime())
    assert(3.isPrime())
    assert(!4.isPrime())
    assert(5.isPrime())
    assert(!6.isPrime())
    assert(7.isPrime())
    assert(!8.isPrime())
    assert(!9.isPrime())
    assert(!10.isPrime())
}

testIsPrime()
