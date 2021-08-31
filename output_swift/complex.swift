struct Complex: ExpressibleByFloatLiteral, AdditiveArithmetic {
    let x: Double
    let y: Double

    static var zero: Complex = Complex(0, 0)
    static var one: Complex = Complex(1, 0)

    var conjugated: Self {
        Complex(x, -y)
    }

    var absolute: Double {
        norm.squareRoot()
    }

    var norm: Double {
        x * x + y * y
    }

    init() {
        self.x = 0
        self.y = 0
    }

    init(floatLiteral value: FloatLiteralType) {
        self.x = value
        self.y = 0
    }

    init(_ x: Double) {
        self.x = x
        self.y = 0
    }

    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }

    static prefix func + (value: Self) -> Self {
        value
    }

    static prefix func - (value: Self) -> Self {
        Complex(-value.x, -value.y)
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        Complex(lhs.x + rhs.x, lhs.y + rhs.y)
    }

    static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    static func - (lhs: Self, rhs: Self) -> Self {
        Complex(lhs.x - rhs.x, lhs.y - rhs.y)
    }

    static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        Complex(lhs.x * rhs.x - lhs.y * rhs.y, lhs.x * rhs.y + lhs.y * rhs.x)
    }

    static func * (lhs: Double, rhs: Self) -> Self {
        Complex(lhs * rhs.x, lhs * rhs.y)
    }

    static func * (lhs: Self, rhs: Double) -> Self {
        Complex(lhs.x * rhs, lhs.y * rhs)
    }

    static func *= (lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }

    static func *= (lhs: inout Self, rhs: Double) {
        lhs = lhs * rhs
    }

    static func / (lhs: Self, rhs: Double) -> Self {
        Complex(lhs.x / rhs, lhs.y / rhs)
    }

    static func / (lhs: Double, rhs: Self) -> Self {
        lhs * rhs.conjugated / rhs.absolute
    }

    static func / (lhs: Self, rhs: Self) -> Self {
        lhs * rhs.conjugated / rhs.norm
    }

    static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }

    static func /= (lhs: inout Self, rhs: Double) {
        lhs = lhs / rhs
    }
}