// snippet_id: 1a5e73a2-96a8-4b3e-8d8b-05eee049765c
// https://github.com/semisagi0/kyopro-snippet
struct Array3D<Element> {
    let n1: Int
    let n2: Int
    let n3: Int
    private var elements: [Element]

    init(repeating: Element, _ n1: Int, _ n2: Int, _ n3: Int) {
        precondition(n1 >= 0)
        precondition(n2 >= 0)
        precondition(n3 >= 0)
        self.n1 = n1
        self.n2 = n2
        self.n3 = n3
        self.elements = [Element](repeating: repeating, count: n1 * n2 * n3)
    }

    subscript(i: Int, j: Int, k: Int) -> Element {
        get {
            #if DEBUG
            precondition(0 <= i && i < n1)
            precondition(0 <= j && j < n2)
            #endif
            return elements[(i * n2 + j) * n3 + k]
        }
        set {
            #if DEBUG
            precondition(0 <= i && i < n1)
            precondition(0 <= j && j < n2)
            #endif
            elements[(i * n2 + j) * n3 + k] = newValue
        }
    }
}

