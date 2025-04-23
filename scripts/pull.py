import os
import sys
import shutil
import shared

print("(cfg) Pulling config files from their respective directories...")

for directory in [shared.WindowsDirectories.ALACRITTY_DIRECTORY,
                  shared.WindowsDirectories.ZED_DIRECTORY,
                  shared.WindowsDirectories.HELIX_DIRECTORY]:
    print(f"(cfg) Pulling from {directory}...")
    shutil.copytree("cfg", directory, dirs_exist_ok=True)

print("(cfg) Done!")
