import Foundation

struct Snippet {
    let url: URL
    let title: String
    let content: String
}

func listSnippets() throws -> [Snippet] {
    let snippetDirectory = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library/Developer/Xcode/UserData/CodeSnippets")
    var result = [Snippet]()
    for url in try FileManager.default.contentsOfDirectory(at: snippetDirectory, includingPropertiesForKeys: nil) {
        let plist = try NSDictionary(contentsOf: url, error: ()) as! [String: Any]
        let title = plist["IDECodeSnippetTitle"]! as! String
        let content = plist["IDECodeSnippetContents"]! as! String
        result.append(Snippet(url: url, title: title, content: content))
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

do {
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
} catch {
    print(error.localizedDescription)
}
