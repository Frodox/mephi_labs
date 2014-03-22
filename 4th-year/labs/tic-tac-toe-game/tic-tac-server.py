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
all communication - a JSON messages
Fields overview:
{ "step":[raw, col]
, "winner":0|1|2	| 0 - nobody win yet. 1 - first. 2 - second. 3 - tie
, "error":0|1		| 0 - no errors, 1 - some error
}

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


				# validate step #
				step_check = {}
				step_check["error"] = 1
				if is_step_correct(user_step, gf):
					step_check["error"] = 0


				# if step is correct,
				## apply user's turn to the game field,
				## check for winners, append this info


				#B answer, is step correct #
				step_check_str = json.dumps(step_check)
				ttc.d("I will send: {0}".format(step_check_str))
				clientsocket.sendall(step_check_str)
				time.sleep(0.1)


				# if an error occured earlier -- get new answer from user
				if step_check["error"] == 1:
					continue;


				# do server step #
				ttc.d("do my turn")
				#server_step = do_server_step()


				# check for winners
				# winner = get_winner(gf) #
				# winner = check_for_winner()
				# if winner exist, append info




				#B send my step with winner result #
				clientsocket.sendall("my step is {0}".format("DEBUG'"))


	except KeyboardInterrupt as exp:
		print ("\nShutting down... {0}".format(exp))
	except Exception as exp:
		print("Sorry, but : {0}".format(exp))
	except:
		print("Unexpected error:", sys.exc_info()[0])



	try:
		clientsocket.close()
		s.close()
	except Exception as exp:
		# not an error on most cases
		ttc.d("may be you will be interested, but {0}".format(exp))

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
		s.bind((my_hostname, ttc.SERVER_PORT))
		# allow max 1 connection at time
		s.listen(1)
		print("Server runs on {0}:{1}\n".format(my_hostname, ttc.SERVER_PORT))
		return s
	except Exception as exp:
		print("Can't init socket on {0}:{1}".format(ttc.SERVER_IP, ttc.SERVER_PORT))
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
	False, if not.
	"""

	ttc.d("step raw: {0}".format(user_step))


	try:

		# convert from json to dict
		step_dict = json.loads(user_step)

		# convert to Int
		step_row = abs(int(step_dict["step"][0]))
		step_col = abs(int(step_dict["step"][1]))

		# check "step" for correctness
		# (in the edges, and not the double-step)
		length = len(gf)
		if step_row >= length or step_col >= length:
			raise Exception("Turn is out of game field.")

	except Exception as exp:
		print("smth realy shitful: {0}".format(exp))
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
