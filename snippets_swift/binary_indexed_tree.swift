// snippet_id: a1cd31a0-4f0e-43ad-ba3f-9dd67501df8c
// https://github.com/semisagi0/kyopro-snippet
struct BinaryIndexedTree<Element> where Element: AdditiveArithmetic {
    private var elements: [Element]

    var count: Int {
        elements.count - 1
    }

    init(_ n: Int) {
        precondition(n >= 0)
        elements = [Element](repeating: .zero, count: n + 1)
    }

    subscript(k: Int) -> Element {
        get {
            return sum(k ..< k + 1)
        }
        set {
            let s = self[k]
            add(at: k, .zero - s)
            add(at: k, newValue)
        }
    }

    mutating func add(at: Int, _ value: Element) {
        precondition((0 ..< count).contains(at))
        var n = at + 1
        while n < elements.count {
            elements[n] += value
            n += n & -n
        }
    }

    private func sum(_ k: Int) -> Element {
        precondition((0 ... count).contains(k))
        var n = k
        var result = Element.zero
        while n > 0 {
            result += elements[n]
            n -= n & -n
        }
        return result
    }

    func sum(_ range: Range<Int>) -> Element {
        sum(range.upperBound) - sum(range.lowerBound)
    }

    func sum(_ range: ClosedRange<Int>) -> Element {
        sum(range.upperBound + 1) - sum(range.lowerBound)
    }

    func sum(_ range: PartialRangeFrom<Int>) -> Element {
        sum(count) - sum(range.lowerBound)
    }

    func sum(_ range: PartialRangeUpTo<Int>) -> Element {
        sum(range.upperBound)
    }

    func sum(_ range: PartialRangeThrough<Int>) -> Element {
        sum(range.upperBound + 1)
    }

    func sum(_ range: UnboundedRange) -> Element {
        sum(count)
    }
}

func testBinaryIndexedTree() {
    func testUpdate() {
        var bit = BinaryIndexedTree<Int>(5)
        bit.add(at: 0, 1) // [1, 0, 0, 0, 0]
        bit.add(at: 1, 2) // [1, 2, 0, 0, 0]
        bit.add(at: 2, 3) // [1, 2, 3, 0, 0]
    }

    func testSum() {
        var bit = BinaryIndexedTree<Int>(5)
        bit.add(at: 0, 1)
        bit.add(at: 1, 2)
        bit.add(at: 2, 4)
        bit.add(at: 3, 8)
        bit.add(at: 4, 16)

        assert(bit.sum(...) == 1 + 2 + 4 + 8 + 16)

        assert(bit.sum(..<0) == 0)
        assert(bit.sum(..<1) == 1)
        assert(bit.sum(..<2) == 1 + 2)
        assert(bit.sum(..<3) == 1 + 2 + 4)
        assert(bit.sum(..<4) == 1 + 2 + 4 + 8)
        assert(bit.sum(..<5) == 1 + 2 + 4 + 8 + 16)

        assert(bit.sum(...0) == 1)
        assert(bit.sum(...1) == 1 + 2)
        assert(bit.sum(...2) == 1 + 2 + 4)
        assert(bit.sum(...3) == 1 + 2 + 4 + 8)
        assert(bit.sum(...4) == 1 + 2 + 4 + 8 + 16)

        assert(bit.sum(0...) == 1 + 2 + 4 + 8 + 16)
        assert(bit.sum(1...) == 2 + 4 + 8 + 16)
        assert(bit.sum(2...) == 4 + 8 + 16)
        assert(bit.sum(3...) == 8 + 16)
        assert(bit.sum(4...) == 16)

        assert(bit.sum(1 ..< 2) == 2)
        assert(bit.sum(1 ..< 3) == 2 + 4)
        assert(bit.sum(1 ..< 4) == 2 + 4 + 8)
        assert(bit.sum(1 ..< 5) == 2 + 4 + 8 + 16)

        assert(bit.sum(0 ..< 0) == 0)
        assert(bit.sum(1 ..< 1) == 0)
        assert(bit.sum(5 ..< 5) == 0)

        assert(bit.sum(1 ... 2) == 2 + 4)
        assert(bit.sum(1 ... 3) == 2 + 4 + 8)
        assert(bit.sum(1 ... 4) == 2 + 4 + 8 + 16)

        assert(bit[0] == 1)
        assert(bit[1] == 2)
        assert(bit[2] == 4)
        assert(bit[3] == 8)
        assert(bit[4] == 16)

        bit[3] = 32
        assert(bit[0] == 1)
        assert(bit[1] == 2)
        assert(bit[2] == 4)
        assert(bit[3] == 32)
        assert(bit[4] == 16)
    }

    testUpdate()
    testSum()
}

testBinaryIndexedTree()
