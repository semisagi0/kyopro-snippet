struct BinaryHeap<Value> {
    private var heap: [Value]
    private var lessThan: (Value, Value) -> Bool

    init(lessThan: @escaping (Value, Value) -> Bool) {
        self.heap = []
        self.lessThan = lessThan
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