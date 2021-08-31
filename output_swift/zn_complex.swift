struct ZnComplex: ExpressibleByIntegerLiteral, AdditiveArithmetic {
    let x: Zn
    let y: Zn

    static var zero: ZnComplex = ZnComplex(0, 0)
    static var one: ZnComplex = ZnComplex(1, 0)
    static var I: ZnComplex = ZnComplex(0, 1)

    var conjugated: Self {
        ZnComplex(x, -y)
    }

    var norm: Zn {
        x * x + y * y
    }

    init() {
        self.x = 0
        self.y = 0
    }

    init(integerLiteral value: IntegerLiteralType) {
        self.x = Zn(value)
        self.y = Zn(0)
    }

    init(_ x: Zn) {
        self.x = x
        self.y = 0
    }

    init(_ x: Zn, _ y: Zn) {
        self.x = x
        self.y = y
    }

    static prefix func + (value: Self) -> Self {
        value
    }

    static prefix func - (value: Self) -> Self {
        ZnComplex(-value.x, -value.y)
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        ZnComplex(lhs.x + rhs.x, lhs.y + rhs.y)
    }

    static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    static func - (lhs: Self, rhs: Self) -> Self {
        ZnComplex(lhs.x - rhs.x, lhs.y - rhs.y)
    }

    static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        ZnComplex(lhs.x * rhs.x - lhs.y * rhs.y, lhs.x * rhs.y + lhs.y * rhs.x)
    }

    static func * (lhs: Zn, rhs: Self) -> Self {
        ZnComplex(lhs * rhs.x, lhs * rhs.y)
    }

    static func * (lhs: Self, rhs: Zn) -> Self {
        ZnComplex(lhs.x * rhs, lhs.y * rhs)
    }

    static func *= (lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }

    static func *= (lhs: inout Self, rhs: Zn) {
        lhs = lhs * rhs
    }

    static func / (lhs: Self, rhs: Zn) -> Self {
        ZnComplex(lhs.x / rhs, lhs.y / rhs)
    }

    static func / (lhs: Zn, rhs: Self) -> Self {
        lhs * rhs.conjugated / rhs.norm
    }

    static func / (lhs: Self, rhs: Self) -> Self {
        lhs * rhs.conjugated / rhs.norm
    }

    static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }

    static func /= (lhs: inout Self, rhs: Zn) {
        lhs = lhs / rhs
    }

    static func ** (lhs: Self, rhs: Int) -> Self {
        lhs.pow(rhs)
    }

    func pow(_ n: Int) -> Self {
        var result: ZnComplex = 1
        var x: ZnComplex = self
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
}
