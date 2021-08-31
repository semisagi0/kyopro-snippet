enum Ordering {
    case less
    case equal
    case greater
}

extension Comparable {
    func compare(other: Self) -> Ordering {
        if self == other {
            return .equal
        } else if self < other {
            return .less
        } else {
            return .greater
        }
    }
}