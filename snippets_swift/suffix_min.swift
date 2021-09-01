extension Array where Element == Int {
    func suffixMin() -> [Element] {
        var result = [Int](repeating: Int.max, count: count + 1)
        for i in (0 ..< count).reversed() {
            result[i] = Swift.min(self[i], result[i + 1])
        }
        return result
    }
}