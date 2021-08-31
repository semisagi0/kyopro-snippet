func treeDiameter(_ G: [[Int]]) -> Int {
    var distance = [Int](repeating: 0, count: G.count)
    func dfs(_ current: Int, _ parent: Int?) {
        for next in G[current] where next != parent {
            distance[next] = distance[current] + 1
            dfs(next, current)
        }
    }
    dfs(0, nil)
    let u = distance.firstIndex(of: distance.max()!)!
    distance[u] = 0
    dfs(u, nil)
    return distance.max()!
}
