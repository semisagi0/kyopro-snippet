struct Array2D<Element> {
    let n1: Int
    let n2: Int
    private var elements: [Element]

    init(repeating: Element, _ n1: Int, _ n2: Int) {
        self.n1 = n1
        self.n2 = n2
        self.elements = [Element](repeating: repeating, count: n1 * n2)
    }

    subscript(i: Int, j: Int) -> Element {
        get {
            elements[i * n2 + j]
        }
        set {
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