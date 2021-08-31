struct PermutationSequence<Element: Comparable>: Sequence, IteratorProtocol {
    private var elements: [Element]?

    mutating func next() -> [Element]? {
        guard let elements = elements else { return nil }
        let results = elements
        var i = elements.count - 2
        while i >= 0, elements[i] >= elements[i + 1] {
            i -= 1
        }
        if i == -1 {
            self.elements = nil
        } else {
            var j = elements.count - 1
            while elements[i] >= elements[j] {
                j -= 1
            }
            self.elements!.swapAt(i, j)
            self.elements![(i + 1)...].reverse()
        }
        return results
    }

    init<Elements: Sequence>(elements: Elements) where Elements.Element == Element {
        self.elements = Array(elements).sorted()
    }

    func makeIterator() -> Iterator {
        self
    }
}