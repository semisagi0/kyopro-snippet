// snippet_id: 3ec5e116-e199-4792-84eb-9525425ec725
// // https://github.com/semisagi0/kyopro-snippet
struct Array4D<Element> {
    let n1: Int
    let n2: Int
    let n3: Int
    let n4: Int
    private var elements: [Element]

    init(repeating: Element, _ n1: Int, _ n2: Int, _ n3: Int, _ n4: Int) {
        precondition(n1 >= 0)
        precondition(n2 >= 0)
        precondition(n3 >= 0)
        precondition(n4 >= 0)
        self.n1 = n1
        self.n2 = n2
        self.n3 = n3
        self.n4 = n4
        self.elements = [Element](repeating: repeating, count: n1 * n2 * n3 * n4)
    }

    subscript(i: Int, j: Int, k: Int, l: Int) -> Element {
        get {
            #if DEBUG
            precondition(0 <= i && i < n1)
            precondition(0 <= j && j < n2)
            precondition(0 <= k && k < n3)
            precondition(0 <= l && l < n4)
            #endif
            return elements[((i * n2 + j) * n3 + k) * n4 + l]
        }
        set {
            #if DEBUG
            precondition(0 <= i && i < n1)
            precondition(0 <= j && j < n2)
            precondition(0 <= k && k < n3)
            precondition(0 <= l && l < n4)
            #endif
            elements[((i * n2 + j) * n3 + k) * n4 + l] = newValue
        }
    }
}

