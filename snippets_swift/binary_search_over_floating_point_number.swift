func binarySearch(yes: Double, no: Double, iteration: Int, predicate: (Double) -> Bool) -> Double {
    assert(predicate(yes))
    assert(!predicate(no))
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
