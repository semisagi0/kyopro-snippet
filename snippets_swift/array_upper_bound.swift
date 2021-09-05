// snippet_id: 205bbcf6-55ea-40ba-bf6b-c54e8efe9b90
// https://github.com/semisagi0/kyopro-snippet
extension Array where Element: Comparable {
    func upperBound(_ x: Element) -> Int {
        var yes = count
        var no = -1
        while yes - no > 1 {
            let m = (yes + no) / 2
            if self[m] > x {
                yes = m
            } else {
                no = m
            }
        }
        return yes
    }
}


func testUpperBound() {
    assert([1, 1, 2, 3, 3].upperBound(0) == 0)
    assert([1, 1, 2, 3, 3].upperBound(1) == 2)
    assert([1, 1, 2, 3, 3].upperBound(2) == 3)
    assert([1, 1, 2, 3, 3].upperBound(3) == 5)
    assert([1, 1, 2, 3, 3].upperBound(4) == 5)
}

testUpperBound()