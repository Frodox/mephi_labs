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
import tic_tac_common as ttc

import socket
import sys


# ---------------------------------------------------------------------------- #

def main():

	try:
		s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		my_hostname = socket.gethostname()
		print("server runs on {0}\n".format(my_hostname))
		s.bind((my_hostname, ttc.SERVER_PORT))
		s.listen(1) # allow max 1 connection at time
	except Exception as exp:
		print("~> %s" %exp)
		sys.exit(-1)


	try:
		while True:
			print ('Listening...')
			(clientsocket, address) = s.accept()
			print ('Connected by {0}\n'.format(address))

			while True:
				data = clientsocket.recv(1024)
				if not data: 
					print("Closed by peer."); 
					clientsocket.close()
					break;

				print("Client says: {0}".format(data))
				clientsocket.send("Thankx!")

	except KeyboardInterrupt, k:
		print ("Shutting down...")
		clientsocket.close()

	sys.exit(0)


# ---------------------------------------------------------------------------- #

if __name__ == "__main__":
	main()
