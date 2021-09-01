func sort<A, B>(_ a: [A], _ b: [B], by compare: ((A, B), (A, B)) -> Bool) -> ([A], [B]) where A: Comparable, B: Comparable {
    let ab = zip(a, b).sorted(by: compare)
    return (ab.map(\.0), ab.map(\.1))
}

func sort<A, B, C>(_ a: [A], _ b: [B], _ c: [C], by compare: ((A, B, C), (A, B, C)) -> Bool) -> ([A], [B], [C]) where A: Comparable, B: Comparable, C: Comparable {
    let abc = zip(a, b, c).sorted(by: compare)
    return (abc.map(\.0), abc.map(\.1), abc.map(\.2))
}

func sort<A, B, C, D>(_ a: [A], _ b: [B], _ c: [C], _ d: [D], by compare: ((A, B, C, D), (A, B, C, D)) -> Bool) -> ([A], [B], [C], [D]) where A: Comparable, B: Comparable, C: Comparable, D: Comparable {
    let abcd = zip(a, b, c, d).sorted(by: compare)
    return (abcd.map(\.0), abcd.map(\.1), abcd.map(\.2), abcd.map(\.3))
}