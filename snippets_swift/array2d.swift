// snippet_id: 27d5b702-c362-4a2b-a2da-9f0f366e72b2
// https://github.com/semisagi0/kyopro-snippet
struct Array2D<Element> {
    let n1: Int
    let n2: Int
    private var elements: [Element]

    init(repeating: Element, _ n1: Int, _ n2: Int) {
        precondition(n1 >= 0)
        precondition(n2 >= 0)
        self.n1 = n1
        self.n2 = n2
        self.elements = [Element](repeating: repeating, count: n1 * n2)
    }

    init(_ array: [[Element]]) {
        if array.isEmpty {
            self.n1 = 0
            self.n2 = 0
            self.elements = []
            return
        }
        self.n1 = array.count
        self.n2 = array[0].count
        self.elements = [Element]()
        for i in 0 ..< array.count {
            for j in 0 ..< array[i].count {
                self.elements.append(array[i][j])
            }
        }
    }

    subscript(i: Int, j: Int) -> Element {
        get {
#if DEBUG
            precondition(0 <= i && i < n1)
            precondition(0 <= j && j < n2)
#endif
            return elements[i * n2 + j]
        }
        set {
#if DEBUG
            precondition(0 <= i && i < n1)
            precondition(0 <= j && j < n2)
#endif
            elements[i * n2 + j] = newValue
        }
    }

    func row(_ i: Int) -> [Element] {
        (0 ..< n2).map { self[i, $0] }
    }

    func column(_ j: Int) -> [Element] {
        (0 ..< n1).map { self[$0, j] }
    }
}

extension Array2D: CustomDebugStringConvertible {
    var debugDescription: String {
        "[\n    " + (0 ..< n1).map { row($0).debugDescription }.joined(separator: ",\n    ") + "\n]"
    }
}

func testArray2D() {
    func testDebugStringConvertible() {
        let array = Array2D([[1, 2, 3], [4, 5, 6]])
        assert(array.debugDescription ==
"""
[
    [1, 2, 3],
    [4, 5, 6]
]
""")
    }

    testDebugStringConvertible()
}

testArray2D()
