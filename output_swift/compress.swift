func rank<Element: Comparable & Hashable>(_ a: [Element]) -> [Element: Int] {
    var result = [Element: Int]()
    for x in a.sorted() {
        if !result.keys.contains(x) {
            result[x] = result.count
        }
    }
    return result
}

extension Array where Element: Comparable & Hashable {
    func compressed() -> [Int] {
        let r = rank(self)
        return map { r[$0]! }
    }
}