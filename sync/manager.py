import os
import shutil
import platform

from typing import List
from pathlib import Path

on_windows: bool = platform.system() == "Windows"
config_directory = Path(
    str(os.getenv("APPDATA")) if on_windows else str(os.getenv("HOME"))
)


class Config:
    name: str
    repo_path: Path  # Path to the config directory in the repository itself.
    actual_path: Path  # Actual path that the config will be pushed to/pulled from.

    def __init__(self, name: str, repo_path: Path):
        self.name = name.lower()
        self.repo_path = repo_path

        self.actual_path = config_directory / self.name

    def push(self) -> None:
        try:
            shutil.copytree(self.repo_path, self.actual_path, dirs_exist_ok=True)
            print(f"(cfg) Pushed '{self.name}' configuration to '{self.actual_path}'")
        except Exception as e:
            print(
                f"(cfg) Failed to push '{self.name}' configuration to '{self.actual_path}': {e}"
            )

    def pull(self) -> None:
        try:
            shutil.copytree(self.actual_path, self.repo_path, dirs_exist_ok=True)
            print(f"(cfg) Pulled '{self.name}' configuration from '{self.actual_path}'")
        except Exception as e:
            print(
                f"(cfg) Failed to pull '{self.name}' configuration from '{self.actual_path}': {e}"
            )


class Sync:
    configs: List[Config]

    def __init__(self):
        self._collect()

    def _collect(self) -> None:
        self.configs = [
            Config(path.name, path) for path in Path("cfg").iterdir() if path.is_dir()
        ]

    def _cancel_action_cb(self, action: str) -> None:
        print(f"(cfg) User canceled action: '{action}'")
        exit(0)

    def _conf_action(self, action: str) -> bool:
        try:
            conf = input(f"(cfg) Type 'y' to confirm action: '{action}': ")
        except KeyboardInterrupt:
            self._cancel_action_cb(action)
        return conf.lower().startswith("y")

    def push(self) -> None:
        action = "push"
        if not self._conf_action(action):
            self._cancel_action_cb(action)
        for config in self.configs:
            config.push()

    def pull(self) -> None:
        action = "pull"
        if not self._conf_action(action):
            self._cancel_action_cb(action)
        for config in self.configs:
            config.pull()
