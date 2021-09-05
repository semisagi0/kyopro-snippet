// snippet_id: 8d82878e-4927-4f5a-a7f3-51c9668553a2
// https://github.com/semisagi0/kyopro-snippet
struct Scanner {
    private var elements = [String]()
    private var index = 0

    mutating func peek() -> String {
        while elements.count == index {
            elements = readLine()!.split(separator: " ").map(\.description)
            index = 0
        }
        return elements[index]
    }

    mutating func nextString() -> String {
        defer {
            index += 1
        }
        return peek()
    }

    mutating func nextStrings(count n: Int) -> [String] {
        return (0 ..< n).map { _ in nextString() }
    }

    mutating func nextInt() -> Int {
        return Int(nextString())!
    }

    mutating func nextInts(count n: Int) -> [Int] {
        return (0 ..< n).map { _ in nextInt() }
    }

    mutating func nextDouble() -> Double {
        return Double(nextString())!
    }
}