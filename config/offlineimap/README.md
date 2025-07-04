## Offline imap config

This is my config for using offlineimap. It uses `m4` for templating since I
run different configs on different hosts. I generally only run one account per
machine so the templating is geared towards that.

## Dotoverrides

In order for the setup make task to work, there needs to be a
`config/dotoverrides/offlineimap.m4` file with the following content
configured:

```
divert(-1)
define(`ACCOUNT',`account name here')dnl
define(`REMOTEUSER',`mrtazz')dnl
define(`REMOTEPASSITEM',`the keychain item name to use')dnl
define(`REMOTEHOST',`imap host to sync from')dnl
define(`LOCALFOLDER',`local folder to sync to')dnl
define(`POSTSYNCHOOK',`any post sync hooks that should run')dnl
divert(0)dnl
```
