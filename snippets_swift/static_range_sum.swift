struct StaticRangeSum<Element> where Element: AdditiveArithmetic {
    private var prefixSum: [Element]

    init(repeating value: Element, count: Int) {
        prefixSum = [Element]()
        prefixSum.append(.zero)
        for _ in 0 ..< count {
            prefixSum.append(prefixSum.last! + value)
        }
    }

    init<S>(_ sequence: S) where S: Sequence, S.Element == Element {
        prefixSum = [Element]()
        prefixSum.append(.zero)
        for element in sequence {
            prefixSum.append(prefixSum.last! + element)
        }
    }

    subscript(range: UnboundedRange) -> Element {
        prefixSum.last!
    }

    subscript(range: Range<Int>) -> Element {
        prefixSum[range.upperBound] - prefixSum[range.lowerBound]
    }

    subscript<R>(range: R) -> Element where R: RangeExpression, R.Bound == Int {
        self[range.relative(to: 0 ..< prefixSum.count - 1)]
    }
}

func testStaticRangeSum() {
    let sum = StaticRangeSum<Int>([1, 2, 4, 8, 16])

    assert(sum[...] == 1 + 2 + 4 + 8 + 16)

    assert(sum[..<0] == 0)
    assert(sum[..<1] == 1)
    assert(sum[..<2] == 1 + 2)
    assert(sum[..<3] == 1 + 2 + 4)
    assert(sum[..<4] == 1 + 2 + 4 + 8)
    assert(sum[..<5] == 1 + 2 + 4 + 8 + 16)

    assert(sum[...0] == 1)
    assert(sum[...1] == 1 + 2)
    assert(sum[...2] == 1 + 2 + 4)
    assert(sum[...3] == 1 + 2 + 4 + 8)
    assert(sum[...4] == 1 + 2 + 4 + 8 + 16)

    assert(sum[0...] == 1 + 2 + 4 + 8 + 16)
    assert(sum[1...] == 2 + 4 + 8 + 16)
    assert(sum[2...] == 4 + 8 + 16)
    assert(sum[3...] == 8 + 16)
    assert(sum[4...] == 16)

    assert(sum[1 ..< 1] == 0)
    assert(sum[1 ..< 2] == 2)
    assert(sum[1 ..< 3] == 2 + 4)
    assert(sum[1 ..< 4] == 2 + 4 + 8)
    assert(sum[1 ..< 5] == 2 + 4 + 8 + 16)

    assert(sum[1 ... 1] == 2)
    assert(sum[1 ... 2] == 2 + 4)
    assert(sum[1 ... 3] == 2 + 4 + 8)
    assert(sum[1 ... 4] == 2 + 4 + 8 + 16)
}

testStaticRangeSum()
