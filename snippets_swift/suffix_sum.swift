extension Collection where Element: AdditiveArithmetic {
    /// 後方累積和
    ///
    /// ```
    /// assert([].suffixSum() == [0])
    /// assert([1, 2, 3, 4, 5].suffixSum() == [15, 14, 12, 9, 5, 0])
    /// ```
    func suffixSum() -> [Element] {
        var result: [Element] = [.zero]
        for element in reversed() {
            result.append(result.last! + element)
        }
        return result.reversed()
    }
}

func testSuffixSum() {
    assert([].suffixSum() == [0])
    assert([1, 2, 3, 4, 5].suffixSum() == [15, 14, 12, 9, 5, 0])
}

testSuffixSum()
