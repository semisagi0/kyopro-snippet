struct Point: Equatable {
    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    static func - (lhs: Point, rhs: Point) -> Point {
        return Point(lhs.x - rhs.x, lhs.y - rhs.y)
    }

    func cross(_ other: Point) -> Int {
        return self.x * other.y - self.y * other.x
    }
}