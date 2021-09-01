struct Printer {
    private let bufferSize = 4096 * 4
    private var data: [UInt8]
    private var index: Int = 0
    private var intBuffer: [UInt8]

    init() {
        data = .init(repeating: 0, count: bufferSize)
        intBuffer = .init(repeating: 0, count: 30)
    }

    mutating func put(_ x: UInt8) {
        if index == bufferSize {
            FileHandle.standardOutput.write(Data(data))
            index = 0
        }
        data[index] = x
        index += 1
    }

    mutating func flush() {
        FileHandle.standardOutput.write(Data(data[0 ..< index]))
        index = 0
    }

    mutating func print(_ x: Character) {
        put(x.asciiValue!)
    }

    mutating func print(_ x: Int) {
        if x < 0 {
            put(("-" as Character).asciiValue!)
            self.print(-x)
            return
        }
        if x == 0 {
            put(("0" as Character).asciiValue!)
            return
        }
        var k = 30
        var x = x
        while x > 0 {
            k -= 1
            intBuffer[k] = UInt8(x % 10)
            x /= 10
        }
        for x in intBuffer[k...] {
            put(("0" as Character).asciiValue! + x)
        }
    }

    mutating func printSpace() {
        put((" " as Character).asciiValue!)
    }

    mutating func println() {
        put(("\n" as Character).asciiValue!)
    }
}

struct Scanner {
    private let bufferSize = 4096 * 4
    private var data = [UInt8]()
    private var index: Int = 0

    mutating func peek() -> UInt8 {
        if index == data.count {
            data = Array(FileHandle.standardInput.readData(ofLength: bufferSize))
            index = 0
        }
        return data[index]
    }

    mutating func skip() {
        index += 1
    }

    mutating func read() -> UInt8 {
        defer { skip() }
        return peek()
    }

    private mutating func isSpace() -> Bool {
        let x = peek()
        return x == (" " as Character).asciiValue! || x == ("\n" as Character).asciiValue!
    }

    private mutating func isDigit() -> Bool {
        let x = peek()
        return ("0" as Character).asciiValue! <= x && x <= ("9" as Character).asciiValue!
    }

    mutating func nextBytes() -> [UInt8] {
        var result = [UInt8]()
        while isSpace() {
            skip()
        }
        while !isSpace() {
            result.append(read())
        }
        return result
    }

    mutating func next() -> String {
        String(bytes: nextBytes(), encoding: .utf8)!
    }

    mutating func nextInt() -> Int {
        var result = 0
        while isSpace() {
            skip()
        }
        var negative: Bool = false
        if peek() == ("-" as Character).asciiValue! {
            negative = true
            skip()
        }
        while isDigit() {
            result = result * 10 + Int(read() - ("0" as Character).asciiValue!)
        }
        if negative {
            result = -result
        }
        return result
    }
}
