// snippet_id: 79d428a6-df9f-4e13-895a-9171caa1a31b
struct SlopeTrick {
    private var addLeft: Int = 0
    private var addRight: Int = 0
    private var left: BinaryHeap<Int>
    private var right: BinaryHeap<Int>
    private var minimum: Int

    init() {
        self.left = .init(lessThan: >)
        self.right = .init(lessThan: <)
        self.minimum = 0
    }

    private mutating func insertLeft(_ x: Int) {
        left.insert(x + addLeft)
    }

    private func peekLeft() -> Int {
        left.peekMin()! - addLeft
    }

    private mutating func popLeft() -> Int {
        left.extractMin()! - addLeft
    }

    private mutating func insertRight(_ x: Int) {
        right.insert(x - addRight)
    }

    func peekRight() -> Int {
        right.peekMin()! + addRight
    }

    private mutating func popRight() -> Int {
        right.extractMin()! + addRight
    }

    // add max(0, x - a)
    mutating func addPlus(_ a: Int) {
        if !left.isEmpty {
            minimum += max(0, peekLeft() - a)
        }
        insertLeft(a)
        insertRight(popLeft())
    }

    // add max(0, a - x)
    mutating func addMinus(_ a: Int) {
        if !right.isEmpty {
            minimum += max(0, a - peekRight())
        }
        insertRight(a)
        insertLeft(popRight())
    }

    mutating func expand(_ x: Int) {
        addLeft += x
        addRight += x
    }

    func findMinimum() -> Int {
        minimum
    }
}
