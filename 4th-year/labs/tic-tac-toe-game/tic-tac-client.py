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

def main():

	try:
		s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		# if you don't call `bind` (like s.bind((HOST, 7799))) for client,
		# OS will chose some temporary port,
		# through wich client will connect to the given server's port
		# it woukd be smth like 33568 and so on

		s.connect((ttc.SERVER_IP, ttc.SERVER_PORT))
		print("Connected to the server.")
		print("Write message in the promt and hit Return to send.")
		print("Press Ctrl+C to exit.\n")
	except Exception as exp:
		print("~> %s" %exp)
		sys.exit(1)

	try:
		while True:
			msg = raw_input(">: ")
			s.send(msg)
			data = s.recv(1024)
			print("SERVER: {0}".format(data))
	except KeyboardInterrupt, k:
		print ("Shutting down...")

	s.close()
	sys.exit(0)


# ---------------------------------------------------------------------------- #

if __name__ == "__main__":
	main()
