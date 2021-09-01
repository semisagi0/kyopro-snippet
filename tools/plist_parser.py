import xml.etree.ElementTree as ET
import pathlib

def parse_only_string_values(path: pathlib.Path) -> dict[str, str]:
    tree = ET.parse(path)
    root = tree.getroot()
    result = {}
    for child in root:
        if child.tag != 'dict':
            continue

        iterator = iter(child)
        while True:
            try:
                key = next(iterator)
            except StopIteration:
                break
            value = next(iterator)
            if value.tag == 'string':
                result[key.text] = value.text
    return result