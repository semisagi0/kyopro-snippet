// snippet_id: bb85b55e-1021-4f72-a271-5707ac405183
func binarySearch(yes: Int, no: Int, where predicate: (Int) -> Bool) -> Int {
    var yes = yes
    var no = no
    while abs(yes - no) > 1 {
        let x = (yes + no) / 2
        if predicate(x) {
            yes = x
        } else {
            no = x
        }
    }
    return yes
}

func testBinarySearch() {
    assert(binarySearch(yes: 0, no: 100, where: { $0 <= 10 }) == 10)
    assert(binarySearch(yes: 100, no: 0, where: { $0 >= 10 }) == 10)
    assert(binarySearch(yes: -1, no: 10, where: { $0 >= 100 }) == -1)
    assert(binarySearch(yes: 10, no: -1, where: { $0 <= -100 }) == 10)
}

testBinarySearch()