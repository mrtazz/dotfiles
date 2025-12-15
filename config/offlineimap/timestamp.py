#!/usr/bin/env python3

import json
import sys
import time
from pathlib import Path

STATE_FILE=Path("~/.local/state/offlineimap/timestamp").expanduser()

def record_timestamp():
    # dump timestamp to file, we only care about integer precision
    with open(STATE_FILE, "w") as f:
        json.dump({"timestamp": int(time.time())}, f)

def get_timestamp_age():
    try:
        with open(STATE_FILE, "r") as f:
            data = json.load(f)

        print(int(time.time()) - data["timestamp"], end="")
    except Exception as e:
        print(f"Error: {e}")


if __name__ == "__main__":

    if len(sys.argv) > 1:
        match sys.argv[1]:
            case 'record':
                record_timestamp()
            case 'age':
                get_timestamp_age()
            case _:
                print('Unknown command: {}'.format(sys.argv[1]))
    else:
        print("No argument provided")
