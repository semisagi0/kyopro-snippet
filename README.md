# 競プロ用スニペット
Xcode 12で使用している競プロ用のスニペット。コピー・改変OK。

- `output/`: スニペットファイルが格納されている。
- `output_swift/`: 各スニペットファイルからSwiftのソースコードだけを抽出したものが格納されている。

# スニペット変換ツール
そのままスニペットファイルをアップロードしてしまうとファイル名がわかりづらいため、スニペットのファイル名を置換するプログラムを作成し使用した。

## 事前条件
`~/CodeSnippets`から`~/Library/Developer/Xcode/UserData/CodeSnippets`へのシンボリックリンクが作成されている。

## 動作
`~/CodeSnippets`直下にあるすべての`.codesnippet`が`./output`にコピーされ、`IDECodeSnippetContents`に書かれているソースコードが`./output_swift`にコピーされる。

コピーされる際にファイル名は対象スニペットのタイトルに置換される。たとえば、`FE3B62E6-27E4-4F3E-956E-D6D558A47BA6.codesnippet`というファイルは`is_prime.codesnippet`というファイル名に置換されてコピーされる。

## 実行方法
```
python3 main.py
```
