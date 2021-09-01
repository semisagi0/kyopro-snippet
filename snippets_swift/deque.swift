struct Deque<Element> {
    private var elements: [Element?]
    private var l: Int = 0
    private var r: Int = 0

    var count: Int {
        r - l
    }

    var capacity: Int {
        elements.count
    }

    var isEmpty: Bool {
        count == 0
    }

    init() {
        self.elements = [Element?](repeating: nil, count: 1)
    }

    private mutating func reallocate() {
        guard count == elements.count else { return }
        var newElements = [Element?](repeating: nil, count: elements.count * 2)
        for i in l ..< r {
            newElements[i - l] = elements[index(i)]
        }
        elements = newElements
        l = 0
        r = elements.count / 2
    }

    private mutating func index(_ k: Int) -> Int {
        var k = k % elements.count
        if k < 0 {
            k += elements.count
        }
        return k
    }

    private mutating func release(_ k: Int) -> Element {
        let k = index(k)
        let result = elements[k]!
        elements[k] = nil
        return result
    }

    mutating func pushFront(_ newElement: Element) {
        reallocate()
        l -= 1
        elements[index(l)] = newElement
    }

    mutating func pushBack(_ newElement: Element) {
        reallocate()
        elements[index(r)] = newElement
        r += 1
    }

    mutating func popFront() -> Element? {
        guard l < r else { return nil }
        defer { l += 1 }
        return release(l)
    }

    mutating func popBack() -> Element? {
        guard l < r else { return nil }
        r -= 1
        return release(r)
    }
}       