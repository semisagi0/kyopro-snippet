// snippet_id: 7f589b10-6bc0-49b8-9c14-67f010d16ced
func printAtCoder(_ a: [Int], separator: String = " ", offset: Int = 0) {
    print(a.map { $0 + offset }.map(\.description).joined(separator: separator))
}