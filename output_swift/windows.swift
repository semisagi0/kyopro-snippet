extension Sequence {
    /// ```
    /// assert([].windows(2) == [])
    /// assert([1].windows(2) == [])
    /// assert([1, 2, 3, 4, 5].windows(2) == [[1, 2], [2, 3], [3, 4], [4, 5]])
    /// assert([1, 2, 3, 4, 5].windows(3) == [[1, 2, 3], [2, 3, 4], [3, 4, 5]])
    /// ```
    func windows(_ size: Int) -> [[Element]] {
        precondition(size >= 1)
        let array = Array(self)
        guard array.count >= size else { return [] }
        var result: [[Element]] = []
        for i in 0 ... array.count - size {
            result.append(Array(array[i ..< i + size]))
        }
        return result
    }

    /// ```
    /// assert([].paired() == []) // compile error
    /// assert([1].paired() == []) // compile error
    /// assert([1, 2, 3, 4, 5].pairWindows() == [(1, 2), (2, 3), (3, 4), (4, 5)]) // compile error
    /// ```
    func paired() -> [(Element, Element)] {
        windows(2).map { ($0[0], $0[1]) }
    }
}

func testWindows() {
    assert(([] as [Int]).windows(2) == [])
    assert([1].windows(2) == [])
    assert([1, 2, 3, 4, 5].windows(2) == [[1, 2], [2, 3], [3, 4], [4, 5]])
    assert([1, 2, 3, 4, 5].windows(3) == [[1, 2, 3], [2, 3, 4], [3, 4, 5]])
}

testWindows()
