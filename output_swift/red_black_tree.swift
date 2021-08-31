// # red black tree
//
// ## references
// - Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, Clifford Stein. Introduction to Algorithms, The MIT Press, third edition, 2009.
class TreeMap<Key: Comparable, Value> {
    private enum Color {
        case red
        case black
    }

    private class Node {
        var key: Key
        var value: Value
        var left: Node?
        var right: Node?
        var color: Color

        init(key: Key, value: Value) {
            self.key = key
            self.value = value
            self.color = .red
        }
    }

    private var root: Node?

    init() {
    }

    private func rotateLeft(_ x: Node) -> Node {
        let y = x.right!
        x.right = y.left
        y.left = x
        return y
    }

    private func rotateRight(_ x: Node) -> Node {
        let y = x.left!
        x.left = y.right
        y.right = x
        return y
    }

    private func violates(_ x: Node?) -> Bool {
        x?.color == .red && (x?.left?.color == .red || x?.right?.color == .red)
    }

    func contains(key: Key) -> Bool {
        func contains(_ x: Node?) -> Bool {
            guard let x = x else { return false }
            if key == x.key {
                return true
            }
            if key < x.key {
                return contains(x.left)
            } else {
                return contains(x.right)
            }
        }
        return contains(root)
    }

    func find(key: Key) -> Value? {
        func find(_ x: Node?) -> Node? {
            guard let x = x else { return nil }
            if key == x.key {
                return x
            }
            if key < x.key {
                return find(x.left)
            } else {
                return find(x.right)
            }
        }
        return find(root)?.value
    }

    subscript(key: Key) -> Value? {
        get {
            find(key: key)
        }
        set {
            if let newValue = newValue {
                insert(key: key, value: newValue)
            } else {
                // erase element
            }
        }
    }

    func insert(key: Key, value: Value) {
        func insert(_ x: Node?) -> Node {
            guard var x = x else { return Node(key: key, value: value) }
            if key == x.key {
                x.value = value
                return x
            }
            if key < x.key {
                x.left = insert(x.left)
                if violates(x.left) {
                    if x.right?.color == .red {
                        x.color = .red
                        x.left?.color = .black
                        x.right?.color = .black
                    } else {
                        if x.left?.right?.color == .red {
                            x.left = rotateLeft(x.left!)
                        }
                        x.left?.color = .black
                        x.color = .red
                        x = rotateRight(x)
                    }
                }
            } else {
                x.right = insert(x.right)
                if violates(x.right) {
                    if x.left?.color == .red {
                        x.color = .red
                        x.right?.color = .black
                        x.left?.color = .black
                    } else {
                        if x.right?.left?.color == .red {
                            x.right = rotateRight(x.right!)
                        }
                        x.right?.color = .black
                        x.color = .red
                        x = rotateLeft(x)
                    }
                }
            }
            return x
        }
        root = insert(root)
        root?.color = .black
    }
}
