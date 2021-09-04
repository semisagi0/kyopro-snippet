// snippet_id: efd5f79e-85ce-41fe-b01c-3a96662ac177
func makeUndirectedGraph(_ n: Int, _ A: [Int], _ B: [Int]) -> [[Int]] {
    var result = [[Int]](repeating: [], count: n)
    for (a, b) in zip(A, B) {
        result[a].append(b)
        result[b].append(a)
    }
    return result
}