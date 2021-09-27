// snippet_id: efd5f79e-85ce-41fe-b01c-3a96662ac177
// https://github.com/semisagi0/kyopro-snippet
func makeUndirectedGraph(_ n: Int, _ A: [Int], _ B: [Int], offset: Int = 0) -> [[Int]] {
    var result = [[Int]](repeating: [], count: n)
    for (a, b) in zip(A, B) {
        result[a - offset].append(b - offset)
        result[b - offset].append(a - offset)
    }
    return result
}