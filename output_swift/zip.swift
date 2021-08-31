func zip<A, B, C>(_ a: A, _ b: B, _ c: C) -> [(A.Element, B.Element, C.Element)] where A: Sequence, B: Sequence, C: Sequence {
    zip(a, zip(b, c)).map { ($0.0, $0.1.0, $0.1.1) }
}

func zip<A, B, C, D>(_ a: A, _ b: B, _ c: C, _ d: D) -> [(A.Element, B.Element, C.Element, D.Element)] where A: Sequence, B: Sequence, C: Sequence, D: Sequence {
    zip(a, zip(b, zip(c, d))).map { ($0.0, $0.1.0, $0.1.1.0, $0.1.1.1) }
}