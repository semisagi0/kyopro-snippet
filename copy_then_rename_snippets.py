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

# `~CodeSnippets`は`~/Library/Developer/Xcode/UserData/CodeSnippets`へのシンボリックリンク。
snippets_directory = pathlib.PosixPath('~/CodeSnippets').expanduser()

output_directory = pathlib.PosixPath('./output')
output_directory.mkdir(exist_ok=True)

for snippet_path in snippets_directory.glob('*.codesnippet'):
    plist = plist_parser.parse_only_string_values(snippet_path)
    file_name = normalized_name(plist['IDECodeSnippetTitle']) + ".codesnippet"
    shutil.copy(snippet_path, output_directory / file_name)
