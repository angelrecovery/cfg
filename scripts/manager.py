import os
import shutil
import platform

from typing import List
from pathlib import Path

CONFIG_DIR = Path(str(os.getenv("APPDATA")) if platform.system() == "Windows" else
    os.path.join(str(os.getenv("HOME")), ".config"))

class Config:
    def __init__(self, name: str, path: Path):
        self.name = name.lower()
        self.path = path

    def push(self) -> None:
        dest = CONFIG_DIR / self.name
        try:
            shutil.copytree(self.path, dest, dirs_exist_ok=True)
            print(f"(cfg) Pushed '{self.name}' configuration to '{dest}'")
        except Exception as e:
            print(f"(cfg) Failed to push '{self.name}' configuration to '{dest}': {e}")

    def pull(self) -> None:
        src = CONFIG_DIR / self.name
        try:
            shutil.copytree(src, self.path, dirs_exist_ok=True)
            print(f"(cfg) Pulled '{self.name}' configuration from '{src}'")
        except Exception as e:
            print(f"(cfg) Failed to pull '{self.name}' configuration from '{src}': {e}")

class ConfigManager:
    configs: List[Config]
    
    def __init__(self):
        self.configs = []

    def collect(self) -> None:
        self.configs = [
            Config(path.name, path) for path in Path("cfg").iterdir() if path.is_dir()]

    def _confirm(self, action: str) -> bool:
        return input(f"(cfg) Type 'y' to confirm action: \'{action}\': ").lower().startswith("y")

    def push(self) -> None:
        if not self._confirm("push"): return
        for config in self.configs:
            config.push()

    def pull(self) -> None:
        if not self._confirm("pull"): return
        for config in self.configs:
            config.pull()
