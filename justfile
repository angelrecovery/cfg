set shell := ["nu", "-c"]

pull:
    @python ./sync/pull.py

push:
    @python ./sync/push.py
