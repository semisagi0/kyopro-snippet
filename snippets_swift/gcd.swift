/// `a`と`b`の最大公約数を返す。
///
/// ```
/// assert(gcd(0, 0) == 0)
/// assert(gcd(0, 3) == 3)
/// assert(gcd(3, 0) == 3)
/// assert(gcd(6, 10) == 2)
/// assert(gcd(-6, 10) == 2)
/// assert(gcd(6, -10) == 2)
/// assert(gcd(-6, -10) == 2)
/// assert(gcd(11, 13) == 1)
/// ```
func gcd(_ a: Int, _ b: Int) -> Int {
    var a = abs(a)
    var b = abs(b)
    while b != 0 {
        (a, b) = (b, a % b)
    }
    return a
}

func testGCD() {
    assert(gcd(0, 0) == 0)
    assert(gcd(0, 3) == 3)
    assert(gcd(3, 0) == 3)
    assert(gcd(6, 10) == 2)
    assert(gcd(-6, 10) == 2)
    assert(gcd(6, -10) == 2)
    assert(gcd(-6, -10) == 2)
    assert(gcd(11, 13) == 1)
}

testGCD()
