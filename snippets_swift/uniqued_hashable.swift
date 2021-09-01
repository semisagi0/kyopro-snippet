extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        return Array(Set(self))
    }
}
