// snippet_id: d806e8c2-8063-4883-92d1-99c4faa22cfe
infix operator &&=: AssignmentPrecedence

/**
 - Remark:
 短絡評価されないので注意。
 たとえば`x`が`false`の場合、`x = x && f()`では`f()`は評価されないが、`x &&= f()`では`f()`は評価される。
 */
func &&= (lhs: inout Bool, rhs: Bool) {
    lhs = lhs && rhs
}
