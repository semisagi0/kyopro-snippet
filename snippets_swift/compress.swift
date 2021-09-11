// snippet_id: 40a2126d-7ac6-4ae9-b182-48911851898d
// https://github.com/semisagi0/kyopro-snippet
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
