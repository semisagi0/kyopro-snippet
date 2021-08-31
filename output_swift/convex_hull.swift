func convexHull(_ points: [Point]) -> [Point] {
    if points.count <= 2 {
        return points
    }
    let points = points.sorted { lhs, rhs in
        return (lhs.x, lhs.y) < (rhs.x, rhs.y)
    }
    var lowerHull = [Point]()
    for point in points {
        while lowerHull.count >= 2 && (lowerHull[lowerHull.count - 1] - lowerHull[lowerHull.count - 2]).cross(point - lowerHull[lowerHull.count - 1]) <= 0 {
            lowerHull.removeLast()
        }
        lowerHull.append(point)
    }
    var upperHull = [Point]()
    for point in points.reversed() {
        while upperHull.count >= 2 && (upperHull[upperHull.count - 1] - upperHull[upperHull.count - 2]).cross(point - upperHull[upperHull.count - 1]) <= 0 {
            upperHull.removeLast()
        }
        upperHull.append(point)
    }
    lowerHull.removeLast()
    upperHull.removeLast()
    return lowerHull + upperHull
}
