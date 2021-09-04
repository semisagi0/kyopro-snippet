// snippet_id: b31b9e45-2594-4269-a880-ac62284174cf
func lcm(_ a: Int, _ b: Int) -> Int {
    a / gcd(a, b) * b
}

func testLCM() {
    assert(lcm(1, 1) == 1)
    assert(lcm(1, 5) == 5)
    assert(lcm(5, 1) == 5)
    assert(lcm(6, 10) == 30)
    assert(lcm(4, 12) == 12)
    assert(lcm(8, 12) == 24)
}

testLCM()