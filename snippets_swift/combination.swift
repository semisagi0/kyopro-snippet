struct Combination {
    private var factorial: [Zn]
    private var inverseFactorial: [Zn]
    private var inverse: [Zn]

    init() {
        factorial = [1, 1]
        inverseFactorial = [1, 1]
        inverse = [0, 1]
    }

    private mutating func stretch(through: Int) {
        while factorial.count <= through {
            let k = factorial.count
            factorial.append(factorial[k - 1] * k)
            inverse.append(inverse[mod % k] * (mod - mod / k))
            inverseFactorial.append(inverseFactorial[k - 1] * inverse[k])
        }
    }

    /// `n`の階乗
    ///
    /// ```
    /// var combination = Combination()
    /// assert(combination.factorial(0) == 1)
    /// assert(combination.factorial(1) == 1)
    /// assert(combination.factorial(2) == 2)
    /// assert(combination.factorial(3) == 6)
    /// assert(combination.factorial(4) == 24)
    /// assert(combination.factorial(5) == 120)
    /// ```
    mutating func factorial(_ n: Int) -> Zn {
        precondition(n >= 0)
        stretch(through: n)
        return self.factorial[n]
    }

    /// `n`の階乗の逆元
    ///
    /// ```
    /// var combination = Combination()
    /// assert(combination.inverseFactorial(10) * combination.factorial(10) == 1)
    /// ```
    mutating func inverseFactorial(_ n: Int) -> Zn {
        precondition(n >= 0)
        stretch(through: n)
        return self.inverseFactorial[n]
    }

    /// `n`の逆元
    ///
    /// ```
    /// var combination = Combination()
    /// assert(combination.inverse(5) * 5 == 1)
    /// assert(combination.inverse(-5) * -Zn(5) == 1)
    /// ```
    mutating func inverse(_ n: Int) -> Zn {
        precondition(n != 0)
        if n < 0 {
            return -inverse(-n)
        }
        stretch(through: n)
        return self.inverse[n]
    }

    /// `n`個から`r`個取る順列の総数
    ///
    /// ```
    /// var combination = Combination()
    /// assert(combination.P(5, 3) == 5 * 4 * 3)
    /// assert(combination.P(1, 2) == 0)
    /// assert(combination.P(0, 0) == 1)
    /// assert(combination.P(-1, 0) == 0)
    /// assert(combination.P(0, -1) == 0)
    /// assert(combination.P(-1, -1) == 0)
    /// ```
    mutating func P(_ n: Int, _ r: Int) -> Zn {
        guard n >= 0 && r >= 0 && n >= r else { return 0 }
        return self.factorial(n) * self.inverseFactorial(n - r)
    }

    /// `n`個から`r`個取る組合せの総数
    /// `(1+x)^n`の`x^r`の係数
    ///
    /// ```
    /// var combination = Combination()
    /// assert(combination.C(5, 3) == 5 * 4 * 3 / (3 * 2 * 1))
    /// assert(combination.C(1, 2) == 0)
    /// assert(combination.C(0, 0) == 1)
    /// assert(combination.C(-1, 0) == 0)
    /// assert(combination.C(0, -1) == 0)
    /// assert(combination.C(-1, -1) == 0)
    /// ```
    mutating func C(_ n: Int, _ r: Int) -> Zn {
        if r < 0 {
            return 0
        }
        if n >= 0 {
            if n < r {
                return 0
            } else {
                return self.factorial(n) * self.inverseFactorial(n - r) * self.inverseFactorial(r)
            }
        } else {
            if r % 2 == 0 {
                return H(-n, r)
            } else {
                return -H(-n, r)
            }
        }
    }

    /// `n`個から`r`個取る重複組合せの総数
    /// `1/(1-x)^n`の`x^r`の係数
    ///
    /// ```
    /// var combination = Combination()
    /// assert(combination.H(5, 3) == 5 * 6 * 7 / (3 * 2 * 1))
    /// assert(combination.H(1, 2) == 1 * 2 / (2 * 1))
    /// assert(combination.H(0, 0) == 1)
    /// assert(combination.H(-1, 0) == 0)
    /// assert(combination.H(0, -1) == 0)
    /// assert(combination.H(-1, -1) == 0)
    /// ```
    mutating func H(_ n: Int, _ r: Int) -> Zn {
        if r < 0 {
            return 0
        }
        if n > 0 {
            return factorial(n + r - 1) * inverseFactorial(n - 1) * inverseFactorial(r)
        } else {
            if r % 2 == 0 {
                return C(-n, r)
            } else {
                return -C(-n, r)
            }
        }
    }
}

// TODO: nCrとnHrにおいてnが負の場合のテストを書く
func testCombination() {
    if mod < 100 {
        return
    }

    func testFactorial() {
        var combination = Combination()
        assert(combination.factorial(0) == 1)
        assert(combination.factorial(1) == 1)
        assert(combination.factorial(2) == 2)
        assert(combination.factorial(3) == 6)
        assert(combination.factorial(4) == 24)
        assert(combination.factorial(5) == 120)
    }

    func testInverseFactorial() {
        var combination = Combination()
        assert(combination.inverseFactorial(10) * combination.factorial(10) == 1)
    }

    func testInverse() {
        var combination = Combination()
        assert(combination.inverse(5) * 5 == 1)
        assert(combination.inverse(-5) * -Zn(5) == 1)
    }

    func testP() {
        var combination = Combination()
        assert(combination.P(5, 3) == Zn(5) * Zn(4) * Zn(3))
        assert(combination.P(1, 2) == 0)
        assert(combination.P(0, 0) == 1)
        assert(combination.P(-1, 0) == 0)
        assert(combination.P(0, -1) == 0)
        assert(combination.P(-1, -1) == 0)
    }

    func testC() {
        var combination = Combination()
        assert(combination.C(5, 3) == Zn(5) * Zn(4) * Zn(3) / (Zn(3) * Zn(2) * Zn(1)))
        assert(combination.C(1, 2) == 0)
        assert(combination.C(0, 0) == 1)
        assert(combination.C(0, -1) == 0)
    }

    func testH() {
        var combination = Combination()
        assert(combination.H(5, 3) == Zn(5) * Zn(6) * Zn(7) / (Zn(3) * Zn(2) * Zn(1)))
        assert(combination.H(1, 2) == Zn(1) * Zn(2) / (Zn(2) * Zn(1)))
        assert(combination.H(0, 0) == 1)
        assert(combination.H(0, -1) == 0)
    }

    testFactorial()
    testInverseFactorial()
    testInverse()
    testP()
    testC()
    testH()
}

testCombination()