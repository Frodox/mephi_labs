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

## how
all communication --- a JSON messages
Fields overview:
{ "step":[raw, col]
, "winner":0|1|2	| 0 - nobody win yet. 1 - first. 2 - second. 3 - tie
, "error":0|1		| 0 - no errors, 1 - some error
}

every time communication should contain all fields
"""

from __future__ import print_function
import tic_tac_common as ttc

import socket
import sys,  time
import json, random, copy, argparse

# ---------------------------------------------------------------------------- #

# if 1, a server-user will be asked about turn
MULTIPLAYER_MODE=0

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

			gf = copy.deepcopy(ttc.GAME_FIELD)

			### one game, loop until winner or disconnect
			while True:


				#B get user's turn
				try:
					print("Wait for user's turn...")
					user_step = ttc.get_msg_from_socket(clientsocket, exception=True, ex=False)
				except Exception as exp:
					ttc.d(exp)
					break;


				# validate step #
				step_check = {}
				step_check["error"] = not ttc.is_step_correct(user_step, gf) # thus, if True -> error = False


				if not step_check["error"]:
					ttc.apply_turn(user_step, gf, ttc.USER_RAW_STEP)
					step_check["winner"] = get_winner(gf)
					ttc.print_game_field(gf)
				else:
					step_check["winner"] = 0


				#B answer, is step correct #
				step_check_str = json.dumps(step_check)
				ttc.d("I will send: {0}".format(step_check_str))
				clientsocket.sendall(step_check_str)
				time.sleep(0.1)


				# if an error occured earlier -- get new answer from user
				if True == step_check["error"] or 0 != step_check["winner"]:
					continue;

				# do server step #
				ttc.d("proceed server turn")

				server_step_dict = do_server_step(gf)
				ttc.apply_turn(json.dumps(server_step_dict), gf, ttc.SERVER_RAW_STEP)



				# check for winners
				server_step_dict["winner"] = get_winner(gf)
				server_step_dict["error"]  = False


				#B send server turn with winner result
				clientsocket.sendall( json.dumps(server_step_dict) )


				ttc.print_game_field(gf)


	except KeyboardInterrupt as exp:
		print ("\nShutting down... {0}".format(exp))
	except Exception as exp:
		print("Sorry, but: {0}".format(exp))
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

# ---------------------------------------------------------------------------- #

def do_server_step (game_field):
	"""
	Analyze situations on @game_field
	and try to do a step.

	or ask user about turn, if it multiplayer mode.

	@return
		dict in json format with field 'step':[int, int]
	"""
	tmp = {}

	if MULTIPLAYER_MODE == 1:
		tmp_str = ttc.get_turn_from_user (game_field)
		ttc.d("Your step is : {}".format(tmp_str))

		tmp = json.loads(tmp_str)

	else:
		# generally, good to check, that empty sections on @game_field even exist
		random.seed()

		while True:
			tmp["step"] = [random.randrange(1,4), random.randrange(1,4)]
			tmp_json_str = json.dumps(tmp)
			ttc.d("server step: {0}".format(tmp_json_str))
			if ttc.is_step_correct(tmp_json_str, game_field):
				break

	return tmp


# --------------------------------------------------------------------------- #


# --------------------------------------------------------------------------- #

def get_winner (game_field):
	"""
	Analyze game (@game_field) and check, if a Winner exist.

	Return
		0 : nobody
		1 : user one (server | zero  | 5)
		2 : user two (client | cross | 2)
		3 : tie (no more free space)
	"""

	winner = 0
	gf = game_field

	empty = ttc.EMPTY_RAW_STEP  # 1
	cross = ttc.USER_RAW_STEP 	# 2
	zero  = ttc.SERVER_RAW_STEP # 5

	cross_win_line = [cross, cross, cross]
	zero_win_line  = [zero,  zero,  zero]

	length = 3 # let it be hardcoded...


	try:
		
		# check for tie, by counting empty cells on every line
		empty_count = 0
		for line in game_field:
			empty_count += line.count(empty)
		if 0 == empty_count:
			winner = 3
			raise Exception("TIE! no more free space")


		### check for winner

		# by rows and cols...
		for j in range(length):
			row = [ gf[j][i] for i in range(length) ]
			col = [ gf[i][j] for i in range(length) ]
			if col == cross_win_line or row == cross_win_line:
				winner = 2
				raise Exception("User wins!")
			elif col == zero_win_line or row == zero_win_line:
				winner = 1
				raise Exception("Server wins!")


		# by diagonals...
		for diag in [ [gf[0][0], gf[1][1], gf[2][2]], [gf[0][2], gf[1][1], gf[2][0]] ]:
			if diag == cross_win_line:
				winner = 2
				raise Exception("User wins!")
			elif diag == zero_win_line:
				winner = 1
				raise Exception("Server wins!")


	except Exception as ex:
		# do nothing, just goto
		ttc.d(ex)


	return winner




# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #

if __name__ == "__main__":
	# insert some help here

	parser = argparse.ArgumentParser(description='Run a server for Tic-Tac-toe client-server game.')

	parser.add_argument('-p', '--port', help='specify a port, on which listen for new connections',
						type=int)
	parser.add_argument('--debug', help='show debug output', action='store_true')

	parser.add_argument('-m', '--multyplayer', help='YOU want to play with user',
						action='store_true')

	args = parser.parse_args()

	if args.debug:
		ttc.DEBUG = 1
		print("Debug output: On")

	if args.port is not None:
		ttc.SERVER_PORT = args.port

	if args.multyplayer:
		MULTIPLAYER_MODE = 1
		print("Multiplayer mode: On. Autopilot is switched off.")


	main()
