from pathlib import Path
import sys
from importlib import import_module
import os
from math import degrees


def main(source_path, target_path):
    source_path = Path(os.getcwd()) / source_path
    source_path = source_path.relative_to(Path(__file__).parent)
    source_module = ".".join(source_path.with_suffix("").parts)
    data = import_module(source_module).DATA

    module = target_path.parent.name
    if "constants" not in module and "structure" not in module:
        prefix = f"{module}_"
    else:
        prefix = ""

    target_text = []

    for key, value in sorted(data.items()):
        if isinstance(value, bool):
            continue
        if key.endswith("theta"):
            value = degrees(value)
        target_text.append(f"{prefix}{key} = {value};")

    target_text = "\n".join(sorted(target_text))
    target_path.write_text(target_text)


if __name__ == "__main__":
    main(Path(sys.argv[1]), Path(sys.argv[2]))
