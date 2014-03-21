#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
It's a server for Tic Tac Toe game.
It will listen for incoming connections (via socket) on some port,
and then will communicate with client to emulate a game with artificial intelligence.

Usecase: run it on machine with internet. Setup it's IP in the tic_tac_common.py file,
thus a client would connect to the server.
---
# Game protocol description

## communication (send|recv)
1 step (server's or client's)
2 step check status
3 winner result

## how to?
all communication - a JSON msgs
{ "step":[raw, col], "winner":0|1|2, "error":0|1 }

every time communication can contain one or more fields (by needs)
"""

from __future__ import print_function
import tic_tac_common as ttc

import socket
import sys, time
import json

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


				#B get step from user #
				user_step = ttc.get_msg_from_socket(clientsocket, exception=True, ex=False)
				#print("User's step: {0}".format(user_step))


				# validate step #
				step_check = {}
				step_check["error"] = 1
				if is_step_correct(user_step, gf):
					step_check["error"] = 0


				#B answer, is step correct? #
				step_check = json.dumps(step_check)
				ttc.d("I will send: {0}".format(step_check))
				clientsocket.sendall(step_check)
				time.sleep(0.1)


				# apply user step to game field #


				# say_if_winner_exist() #
				# if winner exist, say it
				# otherwise, do step


				# do server step #
				#server_step = do_server_step()


				# winner = get_winner(gf) #
				# winner = check_for_winner()


				#B send my step with winner result #
				clientsocket.sendall("my step not like {0}".format(user_step))


	except KeyboardInterrupt:
		print ("Shutting down... {0}".format(exp))
	except Exception as exp:
		print("Oooops: {0}".format(exp))
	except:
		print("Unexpected error:", sys.exc_info()[0])

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
# ---------------------------- L O G I C ------------------------------------- #
# ---------------------------------------------------------------------------- #
def is_step_correct (user_step, game_field):
	"""
	Perform check, if @user_step is correct,
	according to current game (@game_field)

	Retun True, if correct
	False, if not
	"""

	print("debug, step raw: {0}".format(user_step))


	try:

		# convert from json to dict
		step_dict = json.loads(user_step)

		# convert to Int
		step_row = int(step_dict["step"][0])
		step_col = int(step_dict["step"][1])

		# check "step" for correctness
		# (in the edges, and not the double-step)
		length = len(gf)
		if step_row >= length or step_col >= length:
			raise Exception("Range is out of game field")

	except Exception as exp:
		print("smth realy shitful {0}".format(exp))
		return False

	# return True if it is Ok
	return True

# ---------------------------------------------------------------------------- #

def do_server_step (game_field):
	"""
	Analyze situations on @game_field
	and try to do a step.

	Return list like [raw, col]
	"""

	# check, if empty sections on @game_field even exist

	pass

# ---------------------------------------------------------------------------- #

def get_winner (game_field):
	"""
	Analyze game (@game_field) and check, if a Winner exist.

	Return
		0 : nobody
		1 : user one (server)
		2 : user two (client)
	"""

	pass

# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #

if __name__ == "__main__":
	# insert some help here
	main()
