## Offline imap config

This is my config for using offlineimap. It uses a small golang script for
templating since I started using more than one account on some machines and
the previous m4 templating was too limiting for that.

## Dotoverrides

In order for the setup make task to work, there needs to be a
`config/dotoverrides/offlineimap.yaml` file with the following content
configured:

```yaml
accounts:
  - name: accountname
    remote:
      user: username to log into
      passitem: keychain item to use for the password
      host: remote imap host
    localfolder: "~/location/to/email"
    postsynchook: "~/location/to/hook.sh"
```
