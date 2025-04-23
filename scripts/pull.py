import util
import shutil

for directory in util.directories():
    print(f"(cfg) Pulling from {directory}...")
    shutil.copytree("cfg", directory, dirs_exist_ok=True)

print("(cfg) Done!")
