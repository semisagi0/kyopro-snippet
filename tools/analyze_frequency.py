import pathlib
from collections import Counter
from collections import defaultdict
import re
import os
import datetime

hash_table = {}
for path in pathlib.PosixPath('./snippets_swift').glob('*.swift'):
    with path.open() as file:
        for line in file.readlines():
            line = line.rstrip()
            m = re.fullmatch(r'// snippet_id: (.*)', line)
            if m is not None:
                hash_table[m.group(1)] = path.name

appearance = defaultdict(list)

for path in pathlib.PosixPath('~/atcoder/').expanduser().glob('**/*.swift'):
    with path.open() as file:
        for line in file.readlines():
            line = line.rstrip()
            m = re.fullmatch(r'// snippet_id: (.*)', line)
            if m is not None:
                appearance[m.group(1)].append({
                    'name': (path.parent.parent.name + path.parent.name).upper(),
                    'modified_at': datetime.date.fromtimestamp(os.path.getmtime(path))
                })

print(appearance)

with open('./frequency.md', mode='w') as file:
    for key, values in sorted(appearance.items(), key=lambda x: len(x[1]), reverse=True):
        file.write(f'- {hash_table[key]} ({len(values)} times)\n')
        for value in sorted(values, key=lambda x: x['modified_at'], reverse=True):
            file.write(f'   + {value["name"]}, {value["modified_at"].isoformat()}\n')
