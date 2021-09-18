// snippet_id: ea7826eb-c099-48be-8207-a223e91803ee
// https://github.com/semisagi0/kyopro-snippet
extension Optional {
    mutating func apply(handler: (inout Wrapped) -> Void) {
        self = map {
            var wrapped = $0
            handler(&wrapped)
            return wrapped
        }
    }
}

func testOptionalApply() {
    struct Dog {
        var apples: Int = 10

        mutating func eat() {
            apples -= 1
        }
    }

    func testForSome() {
        var dog: Dog? = .init()
        dog.apply { dog in
            dog.eat()
            dog.eat()
            dog.eat()
        }
        assert(dog?.apples == .some(7))
    }

    func testForNone() {
        var dog: Dog? = nil
        dog.apply { dog in
            dog.eat()
            dog.eat()
            dog.eat()
        }
        assert(dog?.apples == .none)
    }

    testForSome()
    testForNone()
}

testOptionalApply()
