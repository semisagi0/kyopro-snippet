// snippet_id: f416ade0-91ea-4a58-adae-2b05bac173da
// https://github.com/semisagi0/kyopro-snippet
protocol BinarySearchTreeNode {
    associatedtype Node: BinarySearchTreeNode
    associatedtype Key: Comparable
    associatedtype Value
    var left: Node? { get }
    var right: Node? { get }
    var key: Key { get }
    var value: Value { get }
}

protocol BinarySearchTree {
    associatedtype Node: BinarySearchTreeNode where Node.Node == Node
    var root: Node? { get }
}

extension BinarySearchTree {
    func contains(key: Node.Key) -> Bool {
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

    func find(key: Node.Key) -> Node.Value? {
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

    func findKey(lessThan key: Node.Key) -> Node.Key? {
        func f(_ x: Node?) -> Node.Key? {
            guard let x = x else { return nil }
            if key <= x.key {
                return f(x.left)
            } else {
                if let returned = f(x.right) {
                    return returned
                } else {
                    return x.key
                }
            }
        }
        return f(root)
    }

    func findKey(greaterThan key: Node.Key) -> Node.Key? {
        func f(_ x: Node?) -> Node.Key? {
            guard let x = x else { return nil }
            if key >= x.key {
                return f(x.right)
            } else {
                if let returned = f(x.left) {
                    return returned
                } else {
                    return x.key
                }
            }
        }
        return f(root)
    }
}

// ## references
// - Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, Clifford Stein. Introduction to Algorithms, The MIT Press, third edition, 2009.
class RedBlackTreeMap<Key: Comparable, Value>: BinarySearchTree {
    enum Color {
        case red
        case black
    }

    class Node: BinarySearchTreeNode {
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

    var root: Node?

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


class TreapMap<Key, Value>: BinarySearchTree where Key: Comparable {
    class Node: BinarySearchTreeNode {
        var left: Node?
        var right: Node?
        var priority: Int
        var key: Key
        var value: Value

        init(key: Key, value: Value) {
            self.key = key
            self.value = value
            self.left = nil
            self.right = nil
            self.priority = Int.random(in: Int.min ... Int.max)
        }
    }

    var root: Node?

    private static func rotateLeft(_ x: Node) -> Node {
        let y = x.right!
        x.right = y.left
        y.left = x
        return y
    }

    private static func rotateRight(_ x: Node) -> Node {
        let y = x.left!
        x.left = y.right
        y.right = x
        return y
    }

    func insert(key: Key, value: Value) {
        func insert(_ x: Node?) -> Node {
            guard var x = x else {
                return Node(key: key, value: value)
            }
            if key == x.key {
                x.value = value
            } else if key < x.key {
                x.left = insert(x.left)
                if x.left!.priority < x.priority {
                    x = Self.rotateRight(x)
                }
            } else {
                x.right = insert(x.right)
                if x.right!.priority < x.priority {
                    x = Self.rotateLeft(x)
                }
            }
            return x
        }
        self.root = insert(self.root)
    }

    func remove(key: Key) {
        func remove(_ x: Node?) -> Node? {
            guard let x = x else {
                return nil
            }
            if key == x.key {
                func eliminate(_ x: Node) -> Node? {
                    guard let left = x.left else {
                        return x.right
                    }
                    guard let right = x.right else {
                        return x.left
                    }
                    if left.priority < right.priority {
                        let x = Self.rotateRight(x)
                        x.right = eliminate(x.right!)
                        return x
                    } else {
                        let x = Self.rotateLeft(x)
                        x.left = eliminate(x.left!)
                        return x
                    }
                }
                return eliminate(x)
            } else if key < x.key {
                x.left = remove(x.left)
                return x
            } else {
                x.right = remove(x.right)
                return x
            }
        }
        self.root = remove(self.root)
    }
}
