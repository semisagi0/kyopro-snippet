# 競プロ用スニペット
Xcode 12で使用している競プロ用のスニペット。

- `frequency.md`: 各スニペットの使用頻度、使用された問題名の一覧が書かれたファイル。
- `snippets/`: スニペットファイルを格納しているディレクトリ。
- `snippets_swift/`: 各スニペットファイルからSwiftのソースコードだけを抽出したものを格納しているディレクトリ。

# スニペット変換ツール
```
python3 tools/copy_snippets.py
```

```
Copy: 2F323FBF-0EFD-42D7-AE53-B6081CA575E5.codesnippet -> snippets/enumerate_divisors.codesnippet
Copy: 6BB37CD1-98C9-4E25-B445-EF18D4418B20.codesnippet -> snippets/non_negative_remainder.codesnippet
Copy: A6CA297B-A3A0-4C90-9708-6C3BD465AA0B.codesnippet -> snippets/power.codesnippet
Copy: 06AEB47E-A1BC-4D05-A885-4DAEFACCC5F0.codesnippet -> snippets/or_assignment_operator.codesnippet
Copy: 3CAD0648-8899-41F3-A390-0CF5D1BEE0AB.codesnippet -> snippets/suffix_sum.codesnippet
...
Copy: EE4E8824-E17B-46E2-B81D-7747389EF707.codesnippet -> snippets/suffix_max.codesnippet
Copy: A19921BD-8920-4E88-9C03-D9C6B5188844.codesnippet -> snippets/slope_trick.codesnippet
Copy: 93C8553F-3CC4-4341-82A9-4C5AD49912EE.codesnippet -> snippets/divide_then_ceiling.codesnippet
Copy: BAFB9356-C84B-4272-939B-9711B3097754.codesnippet -> snippets/union_find.codesnippet
Copy: B9811617-C1EB-46CC-A8E2-0036F17E8E7E.codesnippet -> snippets/windows.codesnippet
Extract: 2F323FBF-0EFD-42D7-AE53-B6081CA575E5.codesnippet -> snippets_swift/enumerate_divisors.swift
Extract: 6BB37CD1-98C9-4E25-B445-EF18D4418B20.codesnippet -> snippets_swift/non_negative_remainder.swift
Extract: A6CA297B-A3A0-4C90-9708-6C3BD465AA0B.codesnippet -> snippets_swift/power.swift
Extract: 06AEB47E-A1BC-4D05-A885-4DAEFACCC5F0.codesnippet -> snippets_swift/or_assignment_operator.swift
Extract: 3CAD0648-8899-41F3-A390-0CF5D1BEE0AB.codesnippet -> snippets_swift/suffix_sum.swift
...
Extract: EE4E8824-E17B-46E2-B81D-7747389EF707.codesnippet -> snippets_swift/suffix_max.swift
Extract: A19921BD-8920-4E88-9C03-D9C6B5188844.codesnippet -> snippets_swift/slope_trick.swift
Extract: 93C8553F-3CC4-4341-82A9-4C5AD49912EE.codesnippet -> snippets_swift/divide_then_ceiling.swift
Extract: BAFB9356-C84B-4272-939B-9711B3097754.codesnippet -> snippets_swift/union_find.swift
Extract: B9811617-C1EB-46CC-A8E2-0036F17E8E7E.codesnippet -> snippets_swift/windows.swift
```
