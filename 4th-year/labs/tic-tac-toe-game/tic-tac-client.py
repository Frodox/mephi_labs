#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
It's a client for Tic Tac Toe game.

Usecase: run it after server's started.
"""

from __future__ import print_function
import tic_tac_common as tt_common
import sys


# ---------------------------------------------------------------------------- #

def main():
	tt_common.say_hello("client")


# ---------------------------------------------------------------------------- #

if __name__ == "__main__":
	main()
