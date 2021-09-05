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
