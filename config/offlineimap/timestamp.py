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

        return int(time.time()) - data["timestamp"]
    except Exception:
        # we just return -1 here as a signal that something went wrong so it
        # doesn't blow up the tmux bar with error messages
        return -1

def print_formatted_age(age):
    # only seconds
    if age < 60:
        print('{}s'.format(age))
        return
    mins, secs = divmod(age, 60)
    hours, mins = divmod(mins, 60)

    if hours < 1:
        print(f"{mins:02d}m{secs:02d}s")
        return

    print(f"{hours:02d}h{mins:02d}m{secs:02d}s")

if __name__ == "__main__":

    if len(sys.argv) > 1:
        match sys.argv[1]:
            case 'record':
                record_timestamp()
            case 'age':
                age = get_timestamp_age()
                print_formatted_age(age)
            case _:
                print('Unknown command: {}'.format(sys.argv[1]))
    else:
        print("No argument provided")
