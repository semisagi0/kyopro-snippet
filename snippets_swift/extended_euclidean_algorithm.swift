/// `a`と`b`の最大公約数を`g`として、`ax + by = g`を満たす整数`x`と`y`および`g`の組を返す。
///
/// ```
/// let (x, y, g) = extendedGCD(-6, 10)
/// assert(g == 2)
/// assert(-6 * x + 10 * y == g)
/// ```
func extendedGCD(_ a: Int, _ b: Int) -> (x: Int, y: Int, g: Int) {
    var x1 = 1, y1 = 0, z1 = a
    var x2 = 0, y2 = 1, z2 = b
    while z2 != 0 {
        let q = z1 / z2
        (x1, x2) = (x2, x1 - x2 * q)
        (y1, y2) = (y2, y1 - y2 * q)
        (z1, z2) = (z2, z1 - z2 * q)
    }
    if z1 >= 0 {
        return (x: x1, y: y1, g: z1)
    } else {
        return (x: -x1, y: -y1, g: -z1)
    }
}

func testExtendedGCD() {
    let (x, y, g) = extendedGCD(-6, 10)
    assert(g == 2)
    assert(-6 * x + 10 * y == g)
}

testExtendedGCD()