struct Counter<Key: Hashable> {
    private var count: [Key: Int] = [:]

    init() {

    }

    init<S>(_ sequence: S) where S: Sequence, S.Element == Key {
        for element in sequence {
            self[element] += 1
        }
    }

    var keys: Dictionary<Key, Int>.Keys {
        count.keys
    }

    subscript(_ key: Key) -> Int {
        get {
            count[key, default: 0]
        }
        set {
            count[key, default: 0] = newValue
        }
    }
}