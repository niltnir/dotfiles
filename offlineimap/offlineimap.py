#! /usr/bin/env python
from subprocess import check_output

lines = check_output("gpg -dq ~/.offlineimapcred.gpg", shell=True).splitlines()

def get_host():
    return lines[0].rstrip(b"\n")

def get_user():
    return lines[1].rstrip(b"\n")

def get_pass():
    return lines[2].rstrip(b"\n")
