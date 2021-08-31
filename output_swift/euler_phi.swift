/// [https://ja.wikipedia.org/wiki/オイラーのφ関数](https://ja.wikipedia.org/wiki/オイラーのφ関数)
///
/// ```
/// assert(phi(1) == 1) // [1]の中で1と互いに素なものは[1]の1つ
/// assert(phi(5) == 4) // [1,2,3,4,5]の中で5と互いに素なものは[1,2,3,4]の4つ
/// assert(phi(10) == 4) // [1,2,3,4,5,6,7,8,9,10]の中で10と互いに素なものは[1,3,7,9]の4つ
/// ```
func phi(_ n: Int) -> Int {
    precondition(n >= 1)
    var result = n
    var n = n
    var i = 2
    while i * i <= n {
        if n % i == 0 {
            result = result / i * (i - 1)
            while n % i == 0 {
                n /= i
            }
        }
        i += 1
    }
    if n != 1 {
        result = result / n * (n - 1)
    }
    return result
}

func testPhi() {
    assert(phi(1) == 1)
    assert(phi(2) == 1)
    assert(phi(3) == 2)
    assert(phi(4) == 2)
    assert(phi(5) == 4)
    assert(phi(6) == 2)
    assert(phi(7) == 6)
    assert(phi(8) == 4)
    assert(phi(9) == 6)
    assert(phi(10) == 4)
}

testPhi()
