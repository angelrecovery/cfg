import util
import shutil

for directory in util.directories():
    print(f"(cfg) Pushing to {directory}...")
    shutil.copytree(directory, "cfg", dirs_exist_ok=True)

print("(cfg) Done!")
