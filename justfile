set shell := ["nu", "-c"]

pull:
    @uv run ./sync/pull.py

push:
    @uv run ./sync/push.py
