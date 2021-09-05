// snippet_id: a1cd2c61-4932-42fe-8a29-9bb5f3ab2f65
// https://github.com/semisagi0/kyopro-snippet
extension Sequence where Element: Equatable {
    func runLengthEncode() -> [(element: Element, count: Int)] {
        var result = [(element: Element, count: Int)]()
        var previous: Element?
        var count = 0
        for element in self {
            if element != previous {
                if let previous = previous {
                    result.append((element: previous, count: count))
                }
                previous = element
                count = 1
            } else {
                count += 1
            }
        }
        if let previous = previous {
            result.append((element: previous, count: count))
        }
        return result
    }
}

func testRunLengthEncode() {
    func equal<Element1, Element2>(_ a: [(Element1, Element2)], _ b: [(Element1, Element2)]) -> Bool where Element1: Equatable, Element2: Equatable {
        if a.count != b.count {
            return false
        }
        for i in 0 ..< a.count {
            if a[i].0 != b[i].0 || a[i].1 != b[i].1 {
                return false
            }
        }
        return true
    }

    assert(equal(([] as [Int]).runLengthEncode(), []))
    assert(equal(["a"].runLengthEncode(), [("a", 1)]))
    assert(equal(["a", "a"].runLengthEncode(), [("a", 2)]))
    assert(equal(["a", "a", "b"].runLengthEncode(), [("a", 2), ("b", 1)]))
    assert(equal(["a", "a", "b", "b", "b", "a", "a", "c"].runLengthEncode(), [("a", 2), ("b", 3), ("a", 2), ("c", 1)]))
    assert(equal("".runLengthEncode(), []))
    assert(equal("aabbbaac".runLengthEncode(), [("a", 2), ("b", 3), ("a", 2), ("c", 1)]))
}

testRunLengthEncode()
