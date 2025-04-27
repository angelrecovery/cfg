set shell := ["nu", "-c"]

pull:
    @python ./scripts/pull.py

push:
    @python ./scripts/push.py
