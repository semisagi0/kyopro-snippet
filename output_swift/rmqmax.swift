struct RMQmax {
    private var nodes: [Int]
    private var size: Int

    init(_ n: Int) {
        var m = 1
        while m < n {
            m *= 2
        }
        size = m
        nodes = .init(repeating: Int.min, count: m * 2)
    }

    mutating func update(_ k: Int, _ value: Int) {
        var k = k + size - 1
        nodes[k] = value
        while k > 0 {
            k = (k - 1) / 2
            nodes[k] = max(nodes[k * 2 + 1], nodes[k * 2 + 2])
        }
    }

    func query(_ a: Int, _ b: Int) -> Int {
        func f(_ k: Int, _ l: Int, _ r: Int) -> Int {
            if a <= l && r <= b {
                return nodes[k]
            }
            if r <= a || b <= l {
                return Int.min
            }
            let vl = f(k * 2 + 1, l, (l + r) / 2)
            let vr = f(k * 2 + 2, (l + r) / 2, r)
            return max(vl, vr)
        }
        return f(0, 0, size)
    }
}