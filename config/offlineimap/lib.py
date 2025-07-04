from subprocess import check_output

# get an item from the macos keychain
def get_keychain_item(name):
    return check_output("security find-generic-password -w -s {}".format(name), shell=True).decode("utf-8").strip("\n")

# helper methods to sync INBOX first
prioritized = ['INBOX']

def cmp(a, b):
    return (a > b) - (a < b)

def mycmp(x, y):
    for prefix in prioritized:
        xsw = x.startswith(prefix)
        ysw = y.startswith(prefix)
        if xsw and ysw:
            return cmp(x, y)
        elif xsw:
            return -1
        elif ysw:
            return +1
    return cmp(x, y)
