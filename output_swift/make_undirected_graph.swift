func makeUndirectedGraph(_ n: Int, _ A: [Int], _ B: [Int]) -> [[Int]] {
    var result = [[Int]](repeating: [], count: n)
    for (a, b) in zip(A, B) {
        result[a].append(b)
        result[b].append(a)
    }
    return result
}