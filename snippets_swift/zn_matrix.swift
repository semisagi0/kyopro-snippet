struct ZnMatrix {
    private var a: Array2D<Zn>

    init(_ n: Int) {
        self.a = Array2D<Zn>(repeating: 0, n, n)
    }

    var size: Int {
        a.n1
    }

    static func E(_ n: Int) -> ZnMatrix {
        var result = ZnMatrix(n)
        for i in 0 ..< n {
            result[i, i] = 1
        }
        return result
    }

    subscript(i: Int, j: Int) -> Zn {
        get {
            a[i, j]
        }
        set {
            a[i, j] = newValue
        }
    }

    static func * (lhs: ZnMatrix, rhs: ZnMatrix) -> ZnMatrix {
        let n = lhs.size
        var result = ZnMatrix(n)
        for i in 0 ..< n {
            for j in 0 ..< n {
                for k in 0 ..< n {
                    result[i, j] += lhs[i, k] * rhs[k, j]
                }
            }
        }
        return result
    }

    static func ** (lhs: ZnMatrix, rhs: Int) -> ZnMatrix {
        if rhs == 0 {
            return .E(lhs.size)
        } else if rhs % 2 == 1 {
            return lhs * lhs ** (rhs - 1)
        } else {
            return (lhs * lhs) ** (rhs / 2)
        }
    }
}