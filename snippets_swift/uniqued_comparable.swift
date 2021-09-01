extension Array where Element: Comparable {
    func uniqued() -> [Element] {
        var result = [Element]()
        for element in sorted() where element != result.last {
            result.append(element)
        }
        return result
    }
}