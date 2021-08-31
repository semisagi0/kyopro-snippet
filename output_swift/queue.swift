struct Queue<Element> {
    private var deque = Deque<Element>()

    mutating func enqueue(_ newElement: Element) {
        deque.pushBack(newElement)
    }

    mutating func dequeue() -> Element? {
        deque.popFront()
    }
}