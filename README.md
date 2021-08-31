## 事前条件
`~/CodeSnippets`から`~/Library/Developer/Xcode/UserData/CodeSnippets`へのシンボリックリンクが作成されている。

## 実行結果
`~/CodeSnippets`直下にあるすべての`.codesnippet`が`./output`にコピーされる。その際にファイル名を対象スニペットのタイトルに置換する。たとえば、`FE3B62E6-27E4-4F3E-956E-D6D558A47BA6.codesnippet`というファイルは`is_prime.codesnippet`というファイル名に置換されてコピーされる。

## 実行方法
```
python3 copy_then_rename_snippets.py
```
