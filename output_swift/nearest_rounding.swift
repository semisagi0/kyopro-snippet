infix operator /+-: MultiplicationPrecedence // 四捨五入
func /+- (lhs: Int, rhs: Int) -> Int {
    (2 * lhs + 1) /- (2 * rhs)
}