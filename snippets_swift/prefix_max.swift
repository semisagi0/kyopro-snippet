extension Array where Element == Int {
    func prefixMax() -> [Element] {
        var result = [Int](repeating: Int.min, count: count + 1)
        for i in 0 ..< count {
            result[i + 1] = Swift.max(result[i], self[i])
        }
        return result
    }
}