struct BIT {
    private var elements: [Int]

    var count: Int {
        elements.count - 1 // elements[0]を使わないため1を引いておく
    }

    /// 値が`0`で長さが`n`の配列`[0,...,0]`で初期化する
    init(_ n: Int) {
        precondition(n >= 0)
        elements = [Int](repeating: 0, count: n + 1)
    }

    /// `self.elements[at] += value`と同等の操作を行う
    ///
    /// ```
    /// var bit = BIT(5)
    /// bit.update(at: 0, 1) // [1, 0, 0, 0, 0]
    /// bit.update(at: 1, 2) // [1, 2, 0, 0, 0]
    /// bit.update(at: 2, 3) // [1, 2, 3, 0, 0]
    /// ```
    mutating func update(at: Int, _ value: Int) {
        precondition((0 ..< count).contains(at))
        var n = at + 1
        while n < elements.count {
            elements[n] += value
            n += n & -n
        }
    }

    /// - Returns: `elements[0 ..< k].reduce(0, +)`
    ///
    /// ```
    /// var bit = BIT(5)
    /// bit.update(at: 0, 1) // [1, 0, 0, 0, 0]
    /// bit.update(at: 1, 2) // [1, 2, 0, 0, 0]
    /// bit.update(at: 2, 3) // [1, 2, 3, 0, 0]
    /// assert(bit.sum(0) == 0) // [1, 2, 3, 0, 0][0 ..< 0].reduce(0, +) == 0
    /// assert(bit.sum(1) == 1) // [1, 2, 3, 0, 0][0 ..< 1].reduce(0, +) == 1
    /// assert(bit.sum(2) == 3) // [1, 2, 3, 0, 0][0 ..< 2].reduce(0, +) == 1 + 2 == 3
    /// assert(bit.sum(3) == 6) // [1, 2, 3, 0, 0][0 ..< 3].reduce(0, +) == 1 + 2 + 3 == 6
    /// assert(bit.sum(4) == 6) // [1, 2, 3, 0, 0][0 ..< 4].reduce(0, +) == 1 + 2 + 3 + 0 == 6
    /// assert(bit.sum(5) == 6) // [1, 2, 3, 0, 0][0 ..< 5].reduce(0, +) == 1 + 2 + 3 + 0 + 0 == 6
    /// ```
    func sum(_ k: Int) -> Int {
        precondition((0 ... count).contains(k))
        var n = k
        var result = 0
        while n > 0 {
            result += elements[n]
            n -= n & -n
        }
        return result
    }
}

func testBIT() {
    func testUpdate() {
        var bit = BIT(5)
        bit.update(at: 0, 1) // [1, 0, 0, 0, 0]
        bit.update(at: 1, 2) // [1, 2, 0, 0, 0]
        bit.update(at: 2, 3) // [1, 2, 3, 0, 0]
    }

    func testSum() {
        var bit = BIT(5)
        bit.update(at: 0, 1) // [1, 0, 0, 0, 0]
        bit.update(at: 1, 2) // [1, 2, 0, 0, 0]
        bit.update(at: 2, 3) // [1, 2, 3, 0, 0]
        assert(bit.sum(0) == 0) // [1, 2, 3, 0, 0][0 ..< 0].reduce(0, +) == 0
        assert(bit.sum(1) == 1) // [1, 2, 3, 0, 0][0 ..< 1].reduce(0, +) == 1
        assert(bit.sum(2) == 3) // [1, 2, 3, 0, 0][0 ..< 2].reduce(0, +) == 1 + 2 == 3
        assert(bit.sum(3) == 6) // [1, 2, 3, 0, 0][0 ..< 3].reduce(0, +) == 1 + 2 + 3 == 6
        assert(bit.sum(4) == 6) // [1, 2, 3, 0, 0][0 ..< 4].reduce(0, +) == 1 + 2 + 3 + 0 == 6
        assert(bit.sum(5) == 6) // [1, 2, 3, 0, 0][0 ..< 5].reduce(0, +) == 1 + 2 + 3 + 0 + 0 == 6
    }

    testUpdate()
    testSum()
}

testBIT()
