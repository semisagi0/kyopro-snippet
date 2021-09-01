extension Int: SetAlgebra {
    public typealias Element = Int

    public func contains(_ member: Element) -> Bool {
        self >> member & 1 == 1
    }

    public func intersection(_ other: Self) -> Self {
        self & other
    }

    public func union(_ other: Self) -> Self {
        self | other
    }

    public func symmetricDifference(_ other: Self) -> Self {
        self ^ other
    }

    public mutating func formIntersection(_ other: Self) {
        self &= other
    }

    public mutating func formUnion(_ other: Self) {
        self |= other
    }

    public mutating func formSymmetricDifference(_ other: Self) {
        self ^= other
    }

    public mutating func insert(_ newMember: Element) -> (inserted: Bool, memberAfterInsert: Element) {
        if contains(newMember) {
            return (false, newMember)
        } else {
            self |= 1 << newMember
            return (true, newMember)
        }
    }

    public mutating func remove(_ member: Element) -> Element? {
        if contains(member) {
            self &= ~(1 << member)
            return member
        } else {
            return nil
        }
    }

    public mutating func update(with newMember: Element) -> Element? {
        if contains(newMember) {
            return newMember
        } else {
            self |= 1 << newMember
            return nil
        }
    }
}

func testIntSetAlgebra() {
    func testContains() {
        assert(!Int([1, 2, 4, 5]).contains(0))
        assert(Int([1, 2, 4, 5]).contains(1))
        assert(Int([1, 2, 4, 5]).contains(2))
        assert(!Int([1, 2, 4, 5]).contains(3))
        assert(Int([1, 2, 4, 5]).contains(4))
        assert(Int([1, 2, 4, 5]).contains(5))
        assert(!Int([1, 2, 4, 5]).contains(6))
    }

    func testIntersection() {
        assert(([1, 2, 3, 4] as Int).intersection([2, 3, 4, 5]) == [2, 3, 4])
    }

    func testUnion() {
        assert(([1, 2, 3, 4] as Int).union([2, 3, 4, 5]) == [1, 2, 3, 4, 5])
    }

    func testSymmetricDifference() {
        assert(([1, 2, 3, 4] as Int).symmetricDifference([2, 3, 4, 5]) == [1, 5])
    }

    func testInsert() {
        var s: Int = []
        assert(s.insert(0) == (true, 0))
        assert(s.insert(1) == (true, 1))
        assert(s.insert(0) == (false, 0))
        assert(s.insert(1) == (false, 1))
        assert(s.insert(2) == (true, 2))
        assert(s == [0, 1, 2])
    }

    func testRemove() {
        var s: Int = []
        assert(s.remove(0) == nil)
        assert(s.insert(0) == (true, 0))
        assert(s.insert(1) == (true, 1))
        assert(s.remove(0) == 0)
        assert(s.insert(0) == (true, 0))
        assert(s.insert(0) == (false, 0))
        assert(s.remove(1) == 1)
        assert(s == [0])
    }

    func testUpdate() {
        var s: Int = []
        assert(s.update(with: 0) == nil)
        assert(s.update(with: 1) == nil)
        assert(s.update(with: 0) == 0)
        assert(s.update(with: 2) == nil)
        assert(s.update(with: 2) == 2)
        assert(s.update(with: 1) == 1)
    }

    testContains()
    testIntersection()
    testUnion()
    testSymmetricDifference()
    testInsert()
    testRemove()
    testUpdate()
}

testIntSetAlgebra()
