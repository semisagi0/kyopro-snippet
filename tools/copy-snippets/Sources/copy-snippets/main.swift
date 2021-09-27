import Foundation

struct Snippet {
    let url: URL
    let title: String
    let content: String
    let completionPrefix: String
}

func listSnippets() throws -> [Snippet] {
    let snippetDirectory = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library/Developer/Xcode/UserData/CodeSnippets")
    var result = [Snippet]()
    for url in try FileManager.default.contentsOfDirectory(at: snippetDirectory, includingPropertiesForKeys: nil) {
        let plist = try NSDictionary(contentsOf: url, error: ()) as! [String: Any]
        let title = plist["IDECodeSnippetTitle"]! as! String
        let content = plist["IDECodeSnippetContents"]! as! String
        let completionPrefix = plist["IDECodeSnippetCompletionPrefix"] as! String
        result.append(
            Snippet(
                url: url,
                title: title,
                content: content,
                completionPrefix: completionPrefix
            )
        )
    }
    return result
}

extension String {
    func snakecased() -> String {
        self.split(separator: " ").map { $0.lowercased() }.joined(separator: "_")
    }
}

assert("The First Content".snakecased() == "the_first_content")
assert("Apple".snakecased() == "apple")
assert("I have an apple".snakecased() == "i_have_an_apple")

func copySnippets() throws {
    let outputDirectory = URL(string: "file://" + FileManager.default.currentDirectoryPath)!.appendingPathComponent("snippets")
    if !FileManager.default.fileExists(atPath: outputDirectory.path) {
        try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: false, attributes: nil)
    }

    for snippet in try listSnippets() {
        let outputURL = outputDirectory.appendingPathComponent(snippet.title.snakecased()).appendingPathExtension("codesnippet")
        if FileManager.default.fileExists(atPath: outputURL.path) {
            try FileManager.default.removeItem(at: outputURL)
        }
        try FileManager.default.copyItem(
            at: snippet.url,
            to: outputURL
        )
        print("Copied: \(snippet.url.lastPathComponent) => \(outputURL.lastPathComponent)")
    }
}

func extractSnippets() throws {
    let outputSwiftDirectory = URL(string: "file://" + FileManager.default.currentDirectoryPath)!.appendingPathComponent("snippets_swift")
    if !FileManager.default.fileExists(atPath: outputSwiftDirectory.path) {
        try FileManager.default.createDirectory(at: outputSwiftDirectory, withIntermediateDirectories: false, attributes: nil)
    }
    for snippet in try listSnippets() {
        let outputURL = outputSwiftDirectory.appendingPathComponent(snippet.title.snakecased()).appendingPathExtension("swift")
        try snippet.content.write(
            to: outputURL,
            atomically: true,
            encoding: .utf8
        )
        print("Extracted: \(snippet.url.lastPathComponent) => \(outputURL.lastPathComponent)")
    }
}

func translateToVSCode() throws {
    // Place your snippets for swift here. Each snippet is defined under a snippet name and has a prefix, body and
    // description. The prefix is what is used to trigger the snippet and the body will be expanded and inserted. Possible variables are:
    // $1, $2 for tab stops, $0 for the final cursor position, and ${1:label}, ${2:another} for placeholders. Placeholders with the
    // same ids are connected.
    // Example:
    // "Print to console": {
    //     "prefix": "log",
    //     "body": [
    //         "console.log('$1');",
    //         "$2"
    //     ],
    //     "description": "Log output to console"
    // }
    struct Item: Codable {
        let prefix: String
        let body: [String]
        let description: String
    }
    var items = [String: Item]()

    for snippet in try listSnippets() {
        items[snippet.title] = Item(
            prefix: snippet.completionPrefix,
            body: snippet.content.split(whereSeparator: \.isNewline).map(String.init),
            description: ""
        )
    }

    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let jsonData = try encoder.encode(items)
    let jsonString = String(data: jsonData, encoding: .utf8)!

    let outputDirectory = URL(string: "file://" + FileManager.default.currentDirectoryPath)!.appendingPathComponent("vscode")
    if !FileManager.default.fileExists(atPath: outputDirectory.path) {
        try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: false, attributes: nil)
    }

    let outputURL = outputDirectory.appendingPathComponent("swift.json")
    try jsonString.write(
        to: outputURL,
        atomically: true,
        encoding: .utf8
    )
}

do {
    try copySnippets()
    try extractSnippets()
    try translateToVSCode()
} catch {
    print(error.localizedDescription)
}
