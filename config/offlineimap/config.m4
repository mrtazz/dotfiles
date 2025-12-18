divert(0)dnl
[general]
accounts = ACCOUNT
maxsyncaccounts = 1
ui = ttyui
pythonfile=~/.config/offlineimap/lib.py
socktimeout = 30
metadata = ~/.config/offlineimap/metadata

[Account ACCOUNT]
localrepository = `'ACCOUNT`'local
remoterepository = `'ACCOUNT`'remote
autorefresh = 2
postsynchook = POSTSYNCHOOK

[Repository `'ACCOUNT`'local]
type = Maildir
localfolders = LOCALFOLDER
foldersort=mycmp

[Repository `'ACCOUNT`'remote]
type = IMAP
remotehost = REMOTEHOST
remoteuser = REMOTEUSER
remotepasseval = get_keychain_item("REMOTEPASSITEM")
ssl = yes
sslcacertfile = /opt/homebrew/etc/gnutls/cert.pem
foldersort=mycmp
usecompression = no
maxconnections = 1
