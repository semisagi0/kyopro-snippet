extension Array where Element == Int {
    func suffixMax() -> [Element] {
        var result = [Int](repeating: Int.min, count: count + 1)
        for i in (0 ..< count).reversed() {
            result[i] = Swift.max(self[i], result[i + 1])
        }
        return result
    }
}