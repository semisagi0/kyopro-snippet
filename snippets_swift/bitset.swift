// snippet_id: 44f1e354-8515-4060-8b2c-e1b5668fde5d
// // https://github.com/semisagi0/kyopro-snippet
struct Bitset: Equatable {
    private var bits: [UInt64]
    let count: Int

    init(count n: Int) {
        self.count = n
        self.bits = [UInt64](repeating: 0, count: (n + 63) / 64)
    }

    private mutating func normalize() {
        let width = count % 64
        if bits.count > 0 && width != 0 {
            self.bits[bits.count - 1] &= 1 << width - 1
        }
    }

    subscript(index: Int) -> Bool {
        get {
            self.bits[index / 64] >> (index % 64) & 1 == 1
        }
        set {
            if newValue {
                self.bits[index / 64] |= 1 << (index % 64)
            } else {
                self.bits[index / 64] &= ~(1 << (index % 64))
            }
        }
    }

    /// - Complexity: O(n / 64)
    func nonzeroBitCount() -> Int {
        var result = 0
        for i in 0 ..< self.bits.count {
            result += bits[i].nonzeroBitCount
        }
        return result
    }

    static func == (lhs: Bitset, rhs: Bitset) -> Bool {
        for i in 0 ..< lhs.bits.count {
            if lhs.bits[i] != rhs.bits[i] {
                return false
            }
        }
        return true
    }

    static prefix func ~ (value: Bitset) -> Bitset {
        var result = Bitset(count: value.count)
        for i in 0 ..< value.bits.count {
            result.bits[i] = ~value.bits[i]
        }
        result.normalize()
        return result
    }

    static func & (lhs: Bitset, rhs: Bitset) -> Bitset {
        var result = Bitset(count: lhs.count)
        for i in 0 ..< lhs.bits.count {
            result.bits[i] = lhs.bits[i] & rhs.bits[i]
        }
        return result
    }

    static func &= (lhs: inout Bitset, rhs: Bitset) {
        for i in 0 ..< lhs.bits.count {
            lhs.bits[i] &= rhs.bits[i]
        }
    }

    static func | (lhs: Bitset, rhs: Bitset) -> Bitset {
        var result = Bitset(count: lhs.count)
        result.bits.withUnsafeMutableBufferPointer { resultBuffer in
            lhs.bits.withUnsafeBufferPointer { lhsBuffer in
                rhs.bits.withUnsafeBufferPointer { rhsBuffer in
                    for i in 0 ..< lhs.bits.count {
                        resultBuffer[i] = lhsBuffer[i] | rhsBuffer[i]
                    }
                }
            }
        }
        return result
    }

    static func |= (lhs: inout Bitset, rhs: Bitset) {
        for i in 0 ..< lhs.bits.count {
            lhs.bits[i] |= rhs.bits[i]
        }
    }

    static func ^ (lhs: Bitset, rhs: Bitset) -> Bitset {
        var result = Bitset(count: lhs.count)
        for i in 0 ..< lhs.bits.count {
            result.bits[i] = lhs.bits[i] & rhs.bits[i]
        }
        return result
    }

    static func ^= (lhs: inout Bitset, rhs: Bitset) {
        for i in 0 ..< lhs.bits.count {
            lhs.bits[i] ^= rhs.bits[i]
        }
    }

    static func << (lhs: Bitset, rhs: Int) -> Bitset {
        precondition(rhs >= 0)
        var result = Bitset(count: lhs.count)
        let large = rhs / 64
        let small = rhs % 64
        result.bits.withUnsafeMutableBufferPointer { resultBuffer in
            lhs.bits.withUnsafeBufferPointer { lhsBuffer in
                if large <= lhs.bits.count {
                    for i in 0 ..< lhs.bits.count - large {
                        resultBuffer[i + large] |= lhsBuffer[i] << small
                    }
                }
                if large + 1 <= lhs.bits.count {
                    for i in 0 ..< lhs.bits.count - large - 1 {
                        resultBuffer[i + large + 1] |= lhsBuffer[i] >> (64 - small)
                    }
                }
            }
        }
        result.normalize()
        return result
    }

    static func <<= (lhs: inout Bitset, rhs: Int) {
        lhs = lhs << rhs
    }
}

func testBitset() {
    func testLeftShift() {
        var bitset = Bitset(count: 200)
        bitset[1] = true
        bitset[2] = true
        bitset[61] = true
        bitset[63] = true

        var expected = Bitset(count: 200)
        expected[101] = true
        expected[102] = true
        expected[161] = true
        expected[163] = true

        assert(bitset << 100 == expected)
    }
}
