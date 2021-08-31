extension Sequence where Element: Equatable {
    func count(of target: Element) -> Int {
        var result = 0
        for element in self {
            if element == target {
                result += 1
            }
        }
        return result
    }
}

func testCountOf() {
    assert([1, 2, 1, 1, 2].count(of: 1) == 3)
    assert([1, 2, 1, 1, 2].count(of: 2) == 2)
    assert([1, 2, 1, 1, 2].count(of: 3) == 0)
    assert([].count(of: 1) == 0)
}

testCountOf()