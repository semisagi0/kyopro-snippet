import pathlib
import plist_parser
import shutil

# 大文字を小文字に置換し、半角スペースをアンダーバーに置換する。
# ```
# assert(normalized_name("The First Book") == "the_first_book")
# ```
def normalized_name(name):
    name = name.lower().replace(' ', '_')
    return name

snippets_directory = pathlib.PosixPath('~/Library/Developer/Xcode/UserData/CodeSnippets').expanduser()

output_directory = pathlib.PosixPath('./snippets')
output_directory.mkdir(exist_ok=True)

output_swift_directory = pathlib.PosixPath('./snippets_swift')
output_swift_directory.mkdir(exist_ok=True)

for snippet_path in snippets_directory.glob('*.codesnippet'):
    plist = plist_parser.parse_only_string_values(snippet_path)
    file_stem = pathlib.PosixPath(normalized_name(plist['IDECodeSnippetTitle']))
    output_path = output_directory / file_stem.with_suffix(".codesnippet")
    print(f"Copy: {snippet_path.name} -> {output_path}")
    shutil.copy(snippet_path, output_path)

for snippet_path in snippets_directory.glob('*.codesnippet'):
    plist = plist_parser.parse_only_string_values(snippet_path)
    file_stem = pathlib.PosixPath(normalized_name(plist['IDECodeSnippetTitle']))
    output_path = output_swift_directory / file_stem.with_suffix(".swift")
    print(f"Extract: {snippet_path.name} -> {output_path}")
    content = plist['IDECodeSnippetContents']
    with output_path.open(mode='w') as file:
        file.write(content)
