extension Collection where Element: AdditiveArithmetic {
    /// 累積和
    ///
    /// ```
    /// assert([].prefixSum() == [0])
    /// assert([1, 2, 3, 4, 5].prefixSum() == [0, 1, 3, 6, 10, 15])
    /// ```
    func prefixSum() -> [Element] {
        var result: [Element] = [.zero]
        for element in self {
            result.append(result.last! + element)
        }
        return result
    }
}

func testPrefixSum() {
    assert([].prefixSum() == [0])
    assert([1, 2, 3, 4, 5].prefixSum() == [0, 1, 3, 6, 10, 15])
}

testPrefixSum()
