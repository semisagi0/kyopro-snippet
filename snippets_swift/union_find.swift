// snippet_id: 77ea187d-9248-473e-b09b-4876c2f7563e
// https://github.com/semisagi0/kyopro-snippet
/// [https://ja.wikipedia.org/wiki/素集合データ構造](https://ja.wikipedia.org/wiki/素集合データ構造)
protocol UnionFind {
    associatedtype Element

    mutating func find(_ v: Element) -> Element
    mutating func unite(_ u: Element, _ v: Element)
    mutating func count(_ u: Element) -> Int
}

extension UnionFind where Element: Equatable {
    mutating func same(_ x: Element, _ y: Element) -> Bool {
        find(x) == find(y)
    }
}

struct ArrayUnionFind: UnionFind {
    typealias Element = Int

    private var parent: [Int]
    private var count: [Int]

    init(_ n: Int) {
        parent = Array(0 ..< n)
        count = [Int](repeating: 1, count: n)
    }

    mutating func find(_ v: Element) -> Element {
        if v == parent[v] {
            return v
        }
        parent[v] = find(parent[v])
        return parent[v]
    }

    mutating func unite(_ u: Element, _ v: Element) {
        var u = find(u)
        var v = find(v)
        guard u != v else { return }
        if count[u] < count[v] {
            swap(&u, &v)
        }
        count[u] += count[v]
        parent[v] = u
    }

    mutating func count(_ u: Element) -> Int {
        count[find(u)]
    }

    /// ```
    /// var uf = ArrayUnionFind(5)
    /// uf.unite(0, 1)
    /// uf.unite(0, 2)
    /// uf.unite(3, 4)
    /// assert(uf.connectedComponents() == [0: [0, 1, 2], 3: [3, 4]])
    /// ```
    mutating func connectedComponents() -> [Element: [Element]] {
        var result: [Element: [Element]] = [:]
        for element in parent.indices {
            result[find(element), default: []].append(element)
        }
        return result
    }
}

func testArrayUnionFind() {
    func testFind() {
        var uf = ArrayUnionFind(5)
        uf.unite(0, 1)
        uf.unite(0, 2)
        uf.unite(3, 4)
        assert(uf.find(0) == uf.find(1))
        assert(uf.find(0) == uf.find(2))
        assert(uf.find(3) == uf.find(4))
        assert(uf.find(0) != uf.find(3))
        assert(uf.same(0, 1))
        assert(uf.same(0, 2))
        assert(uf.same(3, 4))
        assert(!uf.same(0, 3))
    }

    func testCount() {
        var uf = ArrayUnionFind(5)
        uf.unite(0, 1)
        uf.unite(0, 2)
        uf.unite(3, 4)
        assert(uf.count(0) == 3)
        assert(uf.count(1) == 3)
        assert(uf.count(2) == 3)
        assert(uf.count(3) == 2)
        assert(uf.count(4) == 2)
    }

    func testConnectedComponents() {
        var uf = ArrayUnionFind(5)
        uf.unite(0, 1)
        uf.unite(0, 2)
        uf.unite(3, 4)
        assert(uf.connectedComponents() == [0: [0, 1, 2], 3: [3, 4]])
    }

    testFind()
    testCount()
    testConnectedComponents()
}

testArrayUnionFind()

struct HashedUnionFind<Element>: UnionFind where Element: Hashable {
    typealias Element = Element

    private var parent: [Element: Element]
    private var count: [Element: Int]

    init() {
        parent = [:]
        count = [:]
    }

    /// `v`の代表元を返す。
    ///
    /// ```
    /// var uf = HashedUnionFind<Int>()
    /// uf.unite(0, 1)
    /// uf.unite(0, 2)
    /// uf.unite(3, 4)
    /// assert(uf.find(0) == uf.find(1))
    /// assert(uf.find(0) == uf.find(2))
    /// assert(uf.find(3) == uf.find(4))
    /// ```
    ///
    /// - Complexity: 償却O(log n)
    mutating func find(_ v: Element) -> Element {
        guard let p = parent[v] else { return v }
        if v == p {
            return v
        } else {
            let newParent = find(p)
            parent[v] = newParent
            return newParent
        }
    }

    /// 頂点`u`と頂点`v`を辺で繋ぐ。
    ///
    /// - Complexity: 償却O(log n)
    mutating func unite(_ u: Element, _ v: Element) {
        var u = find(u)
        var v = find(v)
        guard u != v else { return }
        if count[u, default: 1] < count[v, default: 1] {
            swap(&u, &v)
        }
        count[u, default: 1] += count[v, default: 1]
        parent[v] = u
    }

    /// 頂点`u`が属する連結成分の頂点数を返す。
    ///
    /// ```
    /// var uf = HashedUnionFind<Int>()
    /// uf.unite(0, 1)
    /// uf.unite(0, 2)
    /// uf.unite(3, 4)
    /// assert(uf.count(0) == 3)
    /// assert(uf.count(1) == 3)
    /// assert(uf.count(2) == 3)
    /// assert(uf.count(3) == 2)
    /// assert(uf.count(4) == 2)
    /// ```
    ///
    /// - Complexity: 償却O(log n)
    mutating func count(_ u: Element) -> Int {
        count[find(u), default: 1]
    }
}

func testHashedUnionFind() {
    func testFind() {
        var uf = HashedUnionFind<Int>()
        uf.unite(0, 1)
        uf.unite(0, 2)
        uf.unite(3, 4)
        assert(uf.find(0) == uf.find(1))
        assert(uf.find(0) == uf.find(2))
        assert(uf.find(3) == uf.find(4))
        assert(uf.find(0) != uf.find(3))
        assert(uf.same(0, 1))
        assert(uf.same(0, 2))
        assert(uf.same(3, 4))
        assert(!uf.same(0, 3))
    }

    func testCount() {
        var uf = HashedUnionFind<Int>()
        uf.unite(0, 1)
        uf.unite(0, 2)
        uf.unite(3, 4)
        assert(uf.count(0) == 3)
        assert(uf.count(1) == 3)
        assert(uf.count(2) == 3)
        assert(uf.count(3) == 2)
        assert(uf.count(4) == 2)
    }

    testFind()
    testCount()
}

testHashedUnionFind()

