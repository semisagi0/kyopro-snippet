// snippet_id: 479ac407-934b-47be-b700-b4cbafab5f77
infix operator ||=: AssignmentPrecedence

/**
 - Remark:
 短絡評価されないので注意。
 たとえば`x`が`true`の場合、`x = x || f()`では`f()`は評価されないが、`x ||= f()`では`f()`は評価される。
 */
func ||= (lhs: inout Bool, rhs: Bool) {
    lhs = lhs || rhs
}
