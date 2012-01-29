# mutt configuration

## Overview
This is a cleanup of my mutt configuration which I have used for years. It is
heavily based on the mutt config I got many moons ago courtesy
[lordbyte](https://twitter.com/lordbyte).

## Setup
Just clone this repository into your home and either symlink ~/.muttrc to the
basic-settings file or have it source basic-settings. You also have to create
a file called `identity` in your mutt folder with the following settings:


    # basic identity
    set realname="Your name here"
    set from="your primary email address here"
    alternates "alternative mail adresses|separated by pipes"
    set hostname="domain of your primary mail address"

    # imap login
    set my_imap_url="imaps://login:password@imapserver:port/"

    # smtp login
    set my_smtp_url="smtp://login:password@smtpserver:port/"


This should get you going with mutt.
