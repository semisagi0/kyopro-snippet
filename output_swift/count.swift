extension Sequence {
    /// ```
    /// assert([1, 2, 3, 4, 5].count(where: { $0 % 2 == 1 }) == 3)
    /// ```
    func count(where predicate: (Element) -> Bool) -> Int {
        var result = 0
        for element in self {
            if predicate(element) {
                result += 1
            }
        }
        return result
    }
}

func testCount() {
    assert([1, 2, 3, 4, 5].count(where: { $0 % 2 == 1 }) == 3)
    assert([].count(where: { $0 % 2 == 1 }) == 0)
}

testCount()
