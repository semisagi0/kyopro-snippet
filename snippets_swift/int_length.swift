extension Int {
    var length: Int {
        if self < 0 {
            return (-self).length
        } else if self == 0 {
            return 0
        } else {
            return 1 + (self / 10).length
        }
    }
}

func testIntLength() {
    assert(0.length == 0)
    assert(1.length == 1)
    assert(9.length == 1)
    assert(10.length == 2)
    assert(99.length == 2)
    assert(100.length == 3)
    assert(999.length == 3)
    assert(1000.length == 4)
    assert(9999.length == 4)
    assert(10000.length == 5)
    assert(99999.length == 5)
}

testIntLength()
