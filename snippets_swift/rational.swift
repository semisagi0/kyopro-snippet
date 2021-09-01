struct Rational: ExpressibleByIntegerLiteral, AdditiveArithmetic, Comparable, Hashable, CustomStringConvertible {
    private let a: Int
    private let b: Int

    static var zero: Self = .init(0, 1)

    init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }

    init(_ a: Int) {
        self.a = a
        self.b = 1
    }

    init(_ a: Int, _ b: Int) {
        assert(b != 0)
        let g = Rational.gcd(abs(a), abs(b))
        if b > 0 {
            self.a = a / g
            self.b = b / g
        } else {
            self.a = -a / g
            self.b = -b / g
        }
    }

    private static func gcd(_ x: Int, _ y: Int) -> Int {
        if y == 0 {
            return x
        } else {
            return gcd(y, x % y)
        }
    }

    static prefix func - (value: Self) -> Self {
        Self(-value.a, value.b)
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs.a * rhs.b + rhs.a * lhs.b, lhs.b * rhs.b)
    }

    static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    static func - (lhs: Self, rhs: Self) -> Self {
        lhs + -rhs
    }

    static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        Self(lhs.a * rhs.a, lhs.b * rhs.b)
    }

    static func *= (lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }

    static func / (lhs: Self, rhs: Self) -> Self {
        Self(lhs.a * rhs.b, lhs.b * rhs.a)
    }

    static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.a * rhs.b < rhs.a * lhs.b
    }

    var description: String {
        String(a) + "/" + String(b)
    }
}

func testRational() {
    func testInit() {
        assert(Rational(-1, 2) == Rational(1, -2))
        assert(Rational(-1, -2) == Rational(1, 2))
        assert(Rational(-2, -4) == Rational(1, 2))
        assert(Rational(-2, 4) == Rational(-1, 2))
        assert(Rational(2, -4) == Rational(-1, 2))
    }

    func testAddition() {
        assert(Rational(1, 2) + Rational(1, 3) == Rational(5, 6))
        assert(Rational(2, 4) + Rational(2, 6) == Rational(5, 6))
    }

    func testSubtraction() {
        assert(Rational(1, 2) - Rational(1, 3) == Rational(1, 6))
        assert(Rational(1, 3) - Rational(1, 2) == Rational(-1, 6))
    }

    func testMultiplication() {
        assert(Rational(2, 3) * Rational(5, 7) == Rational(10, 21))
        assert(Rational(2, 6) * Rational(10, 7) == Rational(10, 21))
        assert(Rational(-2, 3) * Rational(5, 7) == Rational(-10, 21))
        assert(Rational(2, 3) * Rational(-5, 7) == Rational(-10, 21))
        assert(Rational(-2, 3) * Rational(-5, 7) == Rational(10, 21))
    }

    func testDivision() {
        assert(Rational(2, 3) / Rational(5, 7) == Rational(14, 15))
        assert(Rational(2, 6) / Rational(10, 7) == Rational(7, 30))
        assert(Rational(-2, 3) / Rational(5, 7) == Rational(-14, 15))
        assert(Rational(2, 3) / Rational(-5, 7) == Rational(-14, 15))
        assert(Rational(-2, 3) / Rational(-5, 7) == Rational(14, 15))
    }

    func testLessThan() {
        assert(Rational(1, 3) < Rational(1, 2))
        assert(!(Rational(1, 2) < Rational(1, 2)))
        assert(!(Rational(1, 2) < Rational(1, 3)))
    }

    testInit()
    testAddition()
    testSubtraction()
    testMultiplication()
    testDivision()
    testLessThan()
}

testRational()