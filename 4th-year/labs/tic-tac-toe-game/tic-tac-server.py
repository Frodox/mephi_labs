#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
It's a server for Tic Tac Toe game.
It will listen for incoming connections (via socket) on some port,
and then will communicate with client to emulate a game with artificial intelligence.

Usecase: run it on machine with internet. Setup it's IP in the tic_tac_common.py file,
thus a client would connect to the server.
"""

from __future__ import print_function
import tic_tac_common as tt_common
import sys


# ---------------------------------------------------------------------------- #

def main():
	tt_common.say_hello("server")


# ---------------------------------------------------------------------------- #

if __name__ == "__main__":
	main()
