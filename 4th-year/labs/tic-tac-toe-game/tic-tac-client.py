#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
It's a client for Tic Tac Toe game.

Usecase: run it after server's started.
"""

from __future__ import print_function
import tic_tac_common as ttc

import socket
import sys
import os
import readline


# ---------------------------------------------------------------------------- #

gf = ttc.GAME_FIELD

def main():

	try:
		s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

		print("Connecting to the server...")
		s.connect((ttc.SERVER_IP, ttc.SERVER_PORT))
		print("Connected to {0}:{1}.".format(ttc.SERVER_IP, ttc.SERVER_PORT))
		print("Press Ctrl+C to exit.\n")
	except Exception as exp:
		print("Looks like server not ready yet =\\")
		print("~> %s" %exp)
		sys.exit(1)

	try:
		# loop for one game, untill winner or ^C
		while True:

			hello_msg = s.recv(4096)
			print("{0}".format(hello_msg))

			

			#msg = raw_input(">: ")
			#s.sendall(msg)
	except KeyboardInterrupt, k:
		print ("Shutting down...")

	s.close()
	sys.exit(0)


# ---------------------------------------------------------------------------- #

if __name__ == "__main__":
	main()
