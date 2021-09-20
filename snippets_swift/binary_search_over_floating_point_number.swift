// snippet_id: c29955e9-f71e-436f-94d6-98df5492f8e1
// https://github.com/semisagi0/kyopro-snippet
func binarySearch(yes: Double, no: Double, iteration: Int, predicate: (Double) -> Bool) -> Double {
    func f(yes: Double, no: Double, iteration: Int) -> Double {
        if iteration <= 0 {
            return yes
        }
        let x = (yes + no) / 2
        if predicate(x) {
            return f(yes: x, no: no, iteration: iteration - 1)
        } else {
            return f(yes: yes, no: x, iteration: iteration - 1)
        }
    }
    return f(yes: yes, no: no, iteration: iteration)
}

func testBinarySearchOverReal() {
    assert(abs(binarySearch(yes: 10, no: 0, iteration: 100) { x in
        x * x >= 4
    }) - 2 < 1e-6)
    assert(abs(binarySearch(yes: 0, no: 10, iteration: 100) { x in
        x * x <= 4
    }) - 2 < 1e-6)
}

testBinarySearchOverReal()