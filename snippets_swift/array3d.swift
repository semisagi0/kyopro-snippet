// snippet_id: 1a5e73a2-96a8-4b3e-8d8b-05eee049765c
struct Array3D<Element> {
    let n1: Int
    let n2: Int
    let n3: Int
    private var elements: [Element]
    
    init(repeating: Element, _ n1: Int, _ n2: Int, _ n3: Int) {
        self.n1 = n1
        self.n2 = n2
        self.n3 = n3
        self.elements = [Element](repeating: repeating, count: n1 * n2 * n3)
    }
    
    subscript(i: Int, j: Int, k: Int) -> Element {
        get {
            elements[(i * n2 + j) * n3 + k]
        }
        set {
            elements[(i * n2 + j) * n3 + k] = newValue
        }
    }
}
