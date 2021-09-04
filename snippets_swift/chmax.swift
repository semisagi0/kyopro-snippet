// snippet_id: c829a679-1f44-40c6-9422-bd90be99f81f
func chmax<T: Comparable>(_ x: inout T, _ y: T) {
    x = max(x, y)
}