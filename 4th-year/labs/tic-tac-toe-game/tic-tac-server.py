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

gf = ttc.GAME_FIELD


def print_game_field ():
	for line in gf:
		print(line)





def main():

	s = get_server_socket()

	try:
		# endless loop, for multiple linear games
		while True:

			print ('Waiting for a player...')
			(clientsocket, address) = s.accept()
			print ('New player came from {0}\n'.format(address))

			# one game, loop until winner or disconnect
			while True:

				clientsocket.sendall("Tic Tac Toe server greeting you!\nYou are Welcome!")


				#data = clientsocket.recv(4096)
				#if not data: 
					#print("Closed by peer."); 
					#clientsocket.close()
					#break;

				#print("Client says: {0}".format(data))
				#clientsocket.sendall("Thankx!")


	except KeyboardInterrupt, k:
		print ("Shutting down...")

	clientsocket.close()
	s.close()
	sys.exit(0)




# ---------------------------------------------------------------------------- #
# -------------------- H E L P E R S ----------------------------------------- #
# ---------------------------------------------------------------------------- #

def get_server_socket ():
	"""
	Create server socket and bind it to port and listen for incoming connections
	"""

	try:
		s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		my_hostname = socket.gethostname()
		print("Server runs on {0}\n".format(my_hostname))
		s.bind((my_hostname, ttc.SERVER_PORT))
		# allow max 1 connection at time
		s.listen(1) 
		return s
	except Exception as exp:
		print("Can't init socket")
		print("~> %s" %exp)
		sys.exit(1)



# ---------------------------------------------------------------------------- #

if __name__ == "__main__":
	# insert some help here
	main()
