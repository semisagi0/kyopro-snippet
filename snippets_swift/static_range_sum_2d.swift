// snippet_id: 8f2a8e1d-6970-42ee-bc6d-4f1bc819847d
// https://github.com/semisagi0/kyopro-snippet
struct StaticRangeSum2D<Element> where Element: AdditiveArithmetic {
    private var sum: Array2D<Element>

    init(_ array: Array2D<Element>) {
        sum = Array2D<Element>(repeating: .zero, array.n1 + 1, array.n2 + 1)
        for i in 0 ..< array.n1 {
            for j in 0 ..< array.n2 {
                sum[i + 1, j + 1] = sum[i, j + 1] + sum[i + 1, j] - sum[i, j] + array[i, j]
            }
        }
    }

    subscript(range1: Range<Int>, range2: Range<Int>) -> Element {
        sum[range1.upperBound, range2.upperBound] - sum[range1.lowerBound, range2.upperBound] - sum[range1.upperBound, range2.lowerBound] + sum[range1.lowerBound, range2.lowerBound]
    }

    subscript(range1: UnboundedRange, range2: UnboundedRange) -> Element {
        self[0 ..< sum.n1 - 1, 0 ..< sum.n2 - 1]
    }

    subscript<R1>(range1: R1, range2: UnboundedRange) -> Element where R1: RangeExpression, R1.Bound == Int {
        self[range1.relative(to: 0 ..< sum.n1 - 1), 0 ..< sum.n2 - 1]
    }

    subscript<R2>(range1: UnboundedRange, range2: R2) -> Element where R2: RangeExpression, R2.Bound == Int {
        self[0 ..< sum.n1 - 1, range2.relative(to: 0 ..< sum.n2 - 1)]
    }

    subscript<R1, R2>(range1: R1, range2: R2) -> Element where R1: RangeExpression, R2: RangeExpression, R1.Bound == Int, R2.Bound == Int {
        self[range1.relative(to: 0 ..< sum.n1 - 1), range2.relative(to: 0 ..< sum.n2 - 1)]
    }
}

func testStaticRangeSum2D() {
    let sum = StaticRangeSum2D(
        Array2D([
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
        ])
    )

    assert(sum[0 ..< 3, 0 ..< 3] == 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9)
    assert(sum[0 ..< 3, 0 ..< 2] == 1 + 2 + 4 + 5 + 7 + 8)
    assert(sum[0 ..< 2, 0 ..< 2] == 1 + 2 + 4 + 5)
    assert(sum[1 ..< 2, 1 ..< 2] == 5)
    assert(sum[1 ..< 2, 1 ..< 3] == 5 + 6)
    assert(sum[1 ..< 3, 1 ..< 3] == 5 + 6 + 8 + 9)
    assert(sum[2 ..< 3, 2 ..< 3] == 9)
    assert(sum[3 ..< 3, 0 ..< 3] == 0)
    assert(sum[0 ..< 3, 3 ..< 3] == 0)

    assert(sum[0 ... 2, 0 ... 2] == 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9)
    assert(sum[0 ... 2, 0 ... 1] == 1 + 2 + 4 + 5 + 7 + 8)
    assert(sum[0 ... 1, 0 ... 1] == 1 + 2 + 4 + 5)
    assert(sum[1 ... 1, 1 ... 1] == 5)
    assert(sum[1 ... 1, 1 ... 2] == 5 + 6)
    assert(sum[1 ... 2, 1 ... 2] == 5 + 6 + 8 + 9)
    assert(sum[2 ... 2, 2 ... 2] == 9)

    assert(sum[2 ... 2, ...] == 7 + 8 + 9)
    assert(sum[..., 2 ... 2] == 3 + 6 + 9)

    assert(sum[..., ...] == 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9)
}

testStaticRangeSum2D()
