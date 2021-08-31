struct Zi: Equatable {
    let x, y: Int

    static var zero = Zi(x: 0, y: 0)

    var norm: Int {
        x * x + y * y
    }

    var conjugate: Zi {
        Zi(x: x, y: -y)
    }

    static prefix func - (this: Zi) -> Zi {
        Zi(x: -this.x, y: -this.y)
    }

    static func + (lhs: Zi, rhs: Zi) -> Zi {
        Zi(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func - (lhs: Zi, rhs: Zi) -> Zi {
        Zi(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static func * (lhs: Zi, rhs: Zi) -> Zi {
        Zi(x: lhs.x * rhs.x - lhs.y * rhs.y, y: lhs.x * rhs.y + lhs.y * rhs.x)
    }

    static func / (lhs: Zi, rhs: Zi) -> Zi {
        let z = lhs * rhs.conjugate
        let n = rhs.norm
        return Zi(x: z.x /+- n, y: z.y /+- n)
    }

    static func % (lhs: Zi, rhs: Zi) -> Zi {
        lhs - (lhs / rhs) * rhs
    }

    func gcd(_ other: Zi) -> Zi {
        if other == .zero {
            return self
        } else {
            return other.gcd(self % other)
        }
    }
}
