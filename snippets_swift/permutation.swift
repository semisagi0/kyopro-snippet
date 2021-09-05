// snippet_id: 0a8c4b96-aa94-4ae3-b043-3b8db55728ae
// https://github.com/semisagi0/kyopro-snippet
struct PermutationSequence<Element: Comparable>: Sequence, IteratorProtocol {
    private var elements: [Element]?

    mutating func next() -> [Element]? {
        guard let elements = elements else { return nil }
        let results = elements
        var i = elements.count - 2
        while i >= 0, elements[i] >= elements[i + 1] {
            i -= 1
        }
        if i <= -1 {
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

extension Sequence where Element: Comparable {
    var permutations: PermutationSequence<Element> {
        PermutationSequence(elements: self)
    }
}

func testPermutations() {
    assert(Array(([] as [Int]).permutations) == [[]])
    assert(Array(([1] as [Int]).permutations) == [[1]])
    assert(Array(([1, 2] as [Int]).permutations) == [[1, 2], [2, 1]])
    assert(Array(([2, 1] as [Int]).permutations) == [[1, 2], [2, 1]])
    assert(Array(([1, 1] as [Int]).permutations) == [[1, 1]])
    assert(
        Array(([1, 2, 3] as [Int]).permutations) ==
            [
                [1, 2, 3],
                [1, 3, 2],
                [2, 1, 3],
                [2, 3, 1],
                [3, 1, 2],
                [3, 2, 1]
            ]
    )
    assert(
        Array("abc".permutations) ==
            [
                ["a", "b", "c"],
                ["a", "c", "b"],
                ["b", "a", "c"],
                ["b", "c", "a"],
                ["c", "a", "b"],
                ["c", "b", "a"]
            ]
    )
    assert(Array("aab".permutations) == [["a", "a", "b"], ["a", "b", "a"], ["b", "a", "a"]])
}

testPermutations()
