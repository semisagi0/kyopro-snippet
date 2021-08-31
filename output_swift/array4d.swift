struct Array4D<Element> {
    let n1: Int
    let n2: Int
    let n3: Int
    let n4: Int
    private var elements: [Element]
    
    init(repeating: Element, _ n1: Int, _ n2: Int, _ n3: Int, _ n4: Int) {
        self.n1 = n1
        self.n2 = n2
        self.n3 = n3
        self.n4 = n4
        self.elements = [Element](repeating: repeating, count: n1 * n2 * n3 * n4)
    }
    
    subscript(i: Int, j: Int, k: Int, l: Int) -> Element {
        get {
            elements[((i * n2 + j) * n3 + k) * n4 + l]
        }
        set {
            elements[((i * n2 + j) * n3 + k) * n4 + l] = newValue
        }
    }
}
