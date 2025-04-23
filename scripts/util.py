import os
import platform

class UnixDirectories:
    BASE: str = str(os.getenv("HOME"))

    ALACRITTY_DIRECTORY: str = os.path.join(BASE, ".config", "alacritty")
    ZED_DIRECTORY:       str = os.path.join(BASE, ".config", "zed")
    HELIX_DIRECTORY:     str = os.path.join(BASE, ".config", "helix")

class WindowsDirectories:
    BASE: str = str(os.getenv("APPDATA"))

    ALACRITTY_DIRECTORY: str = os.path.join(BASE, "Alacritty")
    ZED_DIRECTORY:       str = os.path.join(BASE, "Zed")
    HELIX_DIRECTORY:     str = os.path.join(BASE, "Helix")

def directories() -> list[str]:
    if platform.system() == "Windows":
        return [WindowsDirectories.ALACRITTY_DIRECTORY,
                WindowsDirectories.ZED_DIRECTORY,
                WindowsDirectories.HELIX_DIRECTORY]
    else:
        return [UnixDirectories.ALACRITTY_DIRECTORY,
                UnixDirectories.ZED_DIRECTORY,
                UnixDirectories.HELIX_DIRECTORY]
