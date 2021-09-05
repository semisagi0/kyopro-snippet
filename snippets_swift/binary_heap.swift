// snippet_id: 8fa5965d-76d1-4de3-a76c-0b57a325733a
// https://github.com/semisagi0/kyopro-snippet
struct BinaryHeap<Value> {
    private var heap: [Value]
    private var lessThan: (Value, Value) -> Bool

    init(lessThan: @escaping (Value, Value) -> Bool) {
        self.heap = []
        self.lessThan = lessThan
    }

    var count: Int {
        heap.count
    }

    var isEmpty: Bool {
        heap.isEmpty
    }

    mutating func insert(_ v: Value) {
        var k = heap.count
        heap.append(v)
        while k > 0 {
            let p = (k - 1) / 2
            if lessThan(heap[k], heap[p]) {
                heap.swapAt(k, p)
                k = p
            } else {
                break
            }
        }
    }

    func peekMin() -> Value? {
        heap.first
    }

    mutating func extractMin() -> Value? {
        guard let result = heap.first else { return nil }
        heap.swapAt(0, heap.endIndex - 1)
        heap.removeLast()
        var k = 0
        while true {
            var l = k
            for c in [k * 2 + 1, k * 2 + 2] where c < heap.count && lessThan(heap[c], heap[l]) {
                l = c
            }
            if k == l {
                break
            }
            heap.swapAt(k, l)
            k = l
        }
        return result
    }
}

func testBinaryHeap() {
    var heap = BinaryHeap<Int>(lessThan: <)
    heap.insert(2)
    heap.insert(1)
    assert(heap.extractMin() == .some(1))
    heap.insert(4)
    heap.insert(3)
    assert(heap.extractMin() == .some(2))
    assert(heap.extractMin() == .some(3))
    assert(heap.extractMin() == .some(4))
    assert(heap.extractMin() == .none)
    heap.insert(5)
    assert(heap.extractMin() == .some(5))
    assert(heap.extractMin() == .none)
}

testBinaryHeap()

extension BinaryHeap: Sequence {
    func makeIterator() -> some IteratorProtocol {
        heap.makeIterator()
    }
}