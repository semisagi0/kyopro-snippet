extension Array where Element == Int {
    func prefixMin() -> [Element] {
        var result = [Int](repeating: Int.max, count: count + 1)
        for i in 0 ..< count {
            result[i + 1] = Swift.min(result[i], self[i])
        }
        return result
    }
}