extension Array where Element: Equatable {
    func uniqued() -> [Element] {
        var result = [Element]()
        for element in self where !result.contains(element) {
            result.append(element)
        }
        return result
    }
}