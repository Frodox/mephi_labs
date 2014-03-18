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
import sys, time


# ---------------------------------------------------------------------------- #

gf = ttc.GAME_FIELD

# ---------------------------------------------------------------------------- #


def main():

	s = get_server_socket()

	try:
		### endless loop, for multiple linear games
		while True:

			print ('Waiting for a player...')
			(clientsocket, address) = s.accept() # blocking line
			print ('New player came from {0}\n'.format(address))
			clientsocket.sendall("Tic Tac Toe server greeting you!\nYou are Welcome!")

			### one game, loop until winner or disconnect
			while True:

				#ttc.print_game_field(gf)

				#B get step srom user #
				user_step = ttc.get_msg_from_socket(clientsocket)
				print("User's step: {0}".format(user_step))

				# validate step #
				# perform some checks

				#B answer, is step correct #
				clientsocket.sendall("Let it be OK while DEBUG")
				time.sleep(0.1)

				# do server step #
				# server_step = do_server_step() 

				# check for winners #
				# winner = check_for_winner()

				#B send my step or Winner result #
				clientsocket.sendall("my step not like {0}".format(user_step))


	except (KeyboardInterrupt, Exception) as exp:
		repr(exp)
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
