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
import json, re, copy


# ---------------------------------------------------------------------------- #


# ---------------------------------------------------------------------------- #


def main():

	s = get_client_socket()

	try:
		# get hello
		hello_msg = ttc.get_msg_from_socket(s)
		print("\n{0}\n".format(hello_msg))

		print('''
You write crosses.
Enter a coordinats, where to put cross.
Suppos, left top corner is (1, 1).
Input in format: <int> <int> <hit Return>
''')
		gf = copy.deepcopy(ttc.GAME_FIELD)
		ttc.print_game_field(gf)

		### loop for a game, untill winner or ^C
		while True:


			#B get a step from user
			turn_json = ttc.get_turn_from_user(gf)


			#B send step to the server
			s.sendall(turn_json)


			#B get server answer about user step
			res = ttc.get_msg_from_socket(s, exception=False, ex=True)


			# if error - ask step again
			if is_error_in_answer(res):
				print("Ou, server not pleasent about your answer, try again.\n")
				continue;
			else:
				ttc.apply_turn(turn_json, gf, ttc.USER_RAW_STEP)


			# check for winners in the answer, if exist any - game ends.
			handle_winner_variable(res)


			#B get server step
			server_step = ttc.get_msg_from_socket(s)
			ttc.d("server step: {0}\n".format(server_step))
			ttc.apply_turn(server_step, gf, ttc.SERVER_RAW_STEP)
			handle_winner_variable(server_step)

			ttc.print_game_field(gf)


	except KeyboardInterrupt as k:
		print ("\nShutting down... {0}".format(k))
	except Exception as exp:
		print(": {0}".format(exp))
		ttc.print_game_field(gf)
	except:
		print("Unexpected error:", sys.exc_info()[0])


	s.close()
	sys.exit(0)


# --------------------------------------------------------------------------- #
# ------------------------------- H E L P E R S ----------------------------- #
# --------------------------------------------------------------------------- #


def get_client_socket ():
	"""
	Create client socket and connect to the server
	"""
	try:
		s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

		print("Connecting to the server...")
		s.connect((ttc.SERVER_IP, ttc.SERVER_PORT))
		print("Connected to {0}:{1}.".format(ttc.SERVER_IP, ttc.SERVER_PORT))
		return s
	except Exception as exp:
		print("Looks like server not ready yet =\\")
		repr(exp)
		sys.exit(1)

# --------------------------------------------------------------------------- #



# ---------------------------------------------------------------------------- #

def is_error_in_answer (msg):
	"""
	Check for error field in @msg.

	@param
		msg --- string in json format

	@return
		True, if field exist and it's 1
		False otherwise
	"""

	try:
		ttc.d("your step validation: {0}".format(msg))
		tmp = json.loads(msg)

		if tmp["error"] == 1:
			return True

	except Exception as exp:
		print("eeem, {0}".format(exp))
		return False

# --------------------------------------------------------------------------- #

def handle_winner_variable (res):
	""" Function doc """

	try:
		tmp = json.loads(res)
		winner = tmp["winner"]

		if 0 == winner :
			pass
		elif 1 == winner:
			raise Exception("Sorry, but you are a loser... =\\")
		elif 2 == winner:
			raise Exception("You win!")
		elif 3 == winner:
			raise Exception("Friendship is wins! (tie)")
		else:
			print("unexpected value")

	except (KeyError, TypeError) as e:
		ttc.d(e)

# --------------------------------------------------------------------------- #

# --------------------------------------------------------------------------- #

# --------------------------------------------------------------------------- #

if __name__ == "__main__":
	ttc.DEBUG = 0
	main()
