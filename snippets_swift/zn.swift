// snippet_id: 5b2dba67-1136-4a0d-84db-d86dc3e7ed7d
let mod = 1000000007
// let mod = 998244353

struct Zn: CustomStringConvertible, AdditiveArithmetic, Hashable, ExpressibleByIntegerLiteral {
    typealias IntegerLiteralType = Int

    let n: Int

    init(_ n: Int) {
        self.n = n
    }

    init(safe n: Int) {
        let m = n % mod
        if m >= 0 {
            self.n = m
        } else {
            self.n = m + mod
        }
    }

    init(integerLiteral value: IntegerLiteralType) {
        self.n = value
    }

    var description: String {
        String(self.n)
    }

    static var zero = Zn(0)
    static var one = Zn(1)

    static prefix func - (value: Self) -> Self {
        return Zn(value.n == 0 ? 0 : mod - value.n)
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        let n = lhs.n + rhs.n
        return Zn(n < mod ? n : n - mod)
    }

    static func + (lhs: Self, rhs: Int) -> Self {
        return lhs + Zn(rhs)
    }

    static func + (lhs: Int, rhs: Self) -> Self {
        return Zn(lhs) + rhs
    }

    static func - (lhs: Self, rhs: Self) -> Self {
        let n = lhs.n - rhs.n
        return Zn(n >= 0 ? n : n + mod)
    }

    static func - (lhs: Self, rhs: Int) -> Self {
        return lhs - Zn(rhs)
    }

    static func - (lhs: Int, rhs: Self) -> Self {
        return Zn(lhs) - rhs
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        Zn((lhs.n * rhs.n) % mod)
    }

    static func * (lhs: Self, rhs: Int) -> Self {
        return lhs * Zn(rhs)
    }

    static func * (lhs: Int, rhs: Self) -> Self {
        return Zn(lhs) * rhs
    }

    static func / (lhs: Zn, rhs: Zn) -> Self {
        return lhs * rhs.inverse
    }

    static func / (lhs: Int, rhs: Zn) -> Self {
        return Zn(lhs) * rhs.inverse
    }

    static func / (lhs: Zn, rhs: Int) -> Self {
        return lhs * Zn(rhs).inverse
    }

    static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    static func += (lhs: inout Self, rhs: Int) {
        lhs = lhs + Zn(rhs)
    }

    static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }

    static func -= (lhs: inout Self, rhs: Int) {
        lhs = lhs - Zn(rhs)
    }

    static func *= (lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }

    static func *= (lhs: inout Self, rhs: Int) {
        lhs = lhs * Zn(rhs)
    }

    static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }

    static func /= (lhs: inout Self, rhs: Int) {
        lhs = lhs / Zn(rhs)
    }

    static func ** (lhs: Self, rhs: Int) -> Self {
        lhs.pow(rhs)
    }

    func pow(_ n: Int) -> Self {
        if n < 0 {
            return inverse.pow(-n)
        }
        var result: Zn = 1
        var x: Zn = self
        var n = n
        while n > 0 {
            if n & 1 == 1 {
                result *= x
            }
            x *= x
            n >>= 1
        }
        return result
    }

    var inverse: Self {
        self.pow(mod - 2)
    }
}

func testZn() {
    /// 0除算を回避するため
    if mod < 100 {
        return
    }

    func testNegation() {
        assert(-Zn(safe: 5) == Zn(safe: -5))
        assert(-Zn(safe: 0) == 0)
    }

    func testAddition() {
        assert((Zn(safe: 3) + Zn(safe: 5)).n == Zn(safe: 8).n)
        assert((Zn(safe: 5) + Zn(safe: -4)).n == Zn(safe: 1).n)
    }

    func testSubtraction() {
        assert(Zn(safe: 5) - Zn(safe: 3) == Zn(safe: 2))
        assert(Zn(safe: 3) - Zn(safe: 5) == Zn(safe: -2))
        assert(Zn(safe: 3) - Zn(safe: 3) == Zn(safe: 0))
    }

    func testMultiplication() {
        assert(Zn(safe: 3) * Zn(safe: 4) == Zn(safe: 12))
        assert(Zn(safe: 3) * Zn(safe: -4) == Zn(safe: -12))
        assert(Zn(safe: -3) * Zn(safe: 4) == Zn(safe: -12))
        assert(Zn(safe: -3) * Zn(safe: -4) == Zn(safe: 12))
        assert(Zn(safe: 3) * Zn(safe: 0) == Zn(safe: 0))
        assert(Zn(safe: 0) * Zn(safe: 3) == Zn(safe: 0))
        assert(Zn(safe: 0) * Zn(safe: 0) == Zn(safe: 0))
    }

    func testDivision() {
        assert(Zn(safe: 3) / Zn(safe: 2) * Zn(safe: 2) == Zn(safe: 3))
        assert(Zn(safe: 3) / Zn(safe: -2) * Zn(safe: -2) == Zn(safe: 3))
        assert(Zn(safe: 3) / Zn(safe: 1) * Zn(safe: 1) == Zn(safe: 3))
        assert(Zn(safe: 3) / Zn(safe: -1) * Zn(safe: -1) == Zn(safe: 3))
        assert(Zn(safe: 0) / Zn(safe: 3) * Zn(safe: 3) == Zn(safe: 0))
    }

    func testPower() {
        assert(Zn(safe: 2).pow(0) == Zn(safe: 1))
        assert(Zn(safe: 2).pow(1) == Zn(safe: 2))
        assert(Zn(safe: 2).pow(2) == Zn(safe: 2 * 2))
        assert(Zn(safe: 2).pow(3) == Zn(safe: 2 * 2 * 2))
        assert(Zn(safe: 2).pow(4) == Zn(safe: 2 * 2 * 2 * 2))
        assert(Zn(safe: 2).pow(5) == Zn(safe: 2 * 2 * 2 * 2 * 2))
        assert(Zn(safe: 2).pow(6) == Zn(safe: 2 * 2 * 2 * 2 * 2 * 2))
        assert(Zn(safe: 2).pow(7) == Zn(safe: 2 * 2 * 2 * 2 * 2 * 2 * 2))
        assert(Zn(safe: 2).pow(8) == Zn(safe: 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2))
        assert(Zn(safe: 2).pow(-1) == Zn(safe: 2).inverse)
        assert(Zn(safe: 2).pow(-2) == Zn(safe: 2 * 2).inverse)
        assert(Zn(safe: 2).pow(-3) == Zn(safe: 2 * 2 * 2).inverse)
        assert(Zn(safe: 2).pow(-4) == Zn(safe: 2 * 2 * 2 * 2).inverse)
        assert(Zn(safe: 2).pow(-5) == Zn(safe: 2 * 2 * 2 * 2 * 2).inverse)
        assert(Zn(safe: 2).pow(-6) == Zn(safe: 2 * 2 * 2 * 2 * 2 * 2).inverse)
        assert(Zn(safe: 2).pow(-7) == Zn(safe: 2 * 2 * 2 * 2 * 2 * 2 * 2).inverse)
        assert(Zn(safe: 2).pow(-8) == Zn(safe: 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2).inverse)
        assert(Zn(safe: 3).pow(0) == Zn(safe: 1))
        assert(Zn(safe: 3).pow(1) == Zn(safe: 3))
        assert(Zn(safe: 3).pow(2) == Zn(safe: 3 * 3))
        assert(Zn(safe: 3).pow(3) == Zn(safe: 3 * 3 * 3))
        assert(Zn(safe: 3).pow(4) == Zn(safe: 3 * 3 * 3 * 3))
        assert(Zn(safe: 3).pow(5) == Zn(safe: 3 * 3 * 3 * 3 * 3))
        assert(Zn(safe: 3).pow(6) == Zn(safe: 3 * 3 * 3 * 3 * 3 * 3))
        assert(Zn(safe: 3).pow(7) == Zn(safe: 3 * 3 * 3 * 3 * 3 * 3 * 3))
        assert(Zn(safe: 3).pow(8) == Zn(safe: 3 * 3 * 3 * 3 * 3 * 3 * 3 * 3))
    }

    func testInverse() {
        assert(Zn(safe: 1).inverse * Zn(safe: 1) == Zn(safe: 1))
        assert(Zn(safe: 2).inverse * Zn(safe: 2) == Zn(safe: 1))
        assert(Zn(safe: 3).inverse * Zn(safe: 3) == Zn(safe: 1))
        assert(Zn(safe: 4).inverse * Zn(safe: 4) == Zn(safe: 1))
        assert(Zn(safe: 5).inverse * Zn(safe: 5) == Zn(safe: 1))
        assert(Zn(safe: 6).inverse * Zn(safe: 6) == Zn(safe: 1))
        assert(Zn(safe: 7).inverse * Zn(safe: 7) == Zn(safe: 1))
        assert(Zn(safe: 8).inverse * Zn(safe: 8) == Zn(safe: 1))
    }

    testNegation()
    testAddition()
    testSubtraction()
    testMultiplication()
    testDivision()
    testPower()
    testInverse()
}

testZn()