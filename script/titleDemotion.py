# 把所有 markdown Title demotion one times

from pathlib import Path
import sys
from pyparsing import line

from yaml import scan

sys.stdout.write("Enter the .md File full path:\n")
sys.stdout.flush()

print("path: " + apath.absolute())

with open(file=path, mode="r", encoding="utf-8") as f1:
    lines = f1.readlines()
    for i in range(0, len(lines)):
        if lines[i][0] == '#':
            lines[i] = '#'+lines[i]

with open(file=path, mode="w", encoding="utf-8")as f2:
    f2.writelines(line)
