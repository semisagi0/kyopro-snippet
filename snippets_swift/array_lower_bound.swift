// snippet_id: 8f13c2c6-8ae3-436d-90da-a0b052b8341f
// https://github.com/semisagi0/kyopro-snippet
extension Array where Element: Comparable {
    func lowerBound(_ x: Element) -> Int {
        var yes = count
        var no = -1
        while yes - no > 1 {
            let m = (yes + no) / 2
            if self[m] >= x {
                yes = m
            } else {
                no = m
            }
        }
        return yes
    }
}

func testLowerBound() {
    assert([1, 1, 2, 3, 3].lowerBound(0) == 0)
    assert([1, 1, 2, 3, 3].lowerBound(1) == 0)
    assert([1, 1, 2, 3, 3].lowerBound(2) == 2)
    assert([1, 1, 2, 3, 3].lowerBound(3) == 3)
    assert([1, 1, 2, 3, 3].lowerBound(4) == 5)
}

testLowerBound()