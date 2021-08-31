extension Character {
    var lowercaseLatinIndex: Int? {
        if let c = self.asciiValue {
            if ("a" as Character).asciiValue! <= c && c <= ("z" as Character).asciiValue! {
                return Int(c - ("a" as Character).asciiValue!)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    var uppercaseLatinIndex: Int? {
        if let c = self.asciiValue {
            if ("A" as Character).asciiValue! <= c && c <= ("Z" as Character).asciiValue! {
                return Int(c - ("A" as Character).asciiValue!)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

func testLowercaseLatinIndex() {
    assert(("a" as Character).lowercaseLatinIndex == .some(0))
    assert(("j" as Character).lowercaseLatinIndex == .some(9))
    assert(("A" as Character).lowercaseLatinIndex == .none)
    assert(("J" as Character).lowercaseLatinIndex == .none)
    assert((" " as Character).lowercaseLatinIndex == .none)
    assert(("あ" as Character).lowercaseLatinIndex == .none)
    assert(("阿" as Character).lowercaseLatinIndex == .none)
    assert("abcdabc".map(\.lowercaseLatinIndex!) == [0, 1, 2, 3, 0, 1, 2])
}

func testUppercaseLatinIndex() {
    assert(("a" as Character).uppercaseLatinIndex == .none)
    assert(("j" as Character).uppercaseLatinIndex == .none)
    assert(("A" as Character).uppercaseLatinIndex == .some(0))
    assert(("J" as Character).uppercaseLatinIndex == .some(9))
    assert((" " as Character).uppercaseLatinIndex == .none)
    assert(("あ" as Character).uppercaseLatinIndex == .none)
    assert(("阿" as Character).uppercaseLatinIndex == .none)
    assert("ABCDABC".map(\.uppercaseLatinIndex!) == [0, 1, 2, 3, 0, 1, 2])
}

testLowercaseLatinIndex()
testUppercaseLatinIndex()
