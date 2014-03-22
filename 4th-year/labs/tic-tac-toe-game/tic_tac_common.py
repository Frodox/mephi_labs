#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
It's common file for server and client.
Contain share settings and common functions.

Usecase: import in client and server scripts.
"""

from __future__ import print_function
import socket
import sys
import json

#SERVER_IP   = 'bitthinker.com'
SERVER_IP   = 'localhost'
SERVER_PORT =  64506

# 1 : empty
# 2 : cross
# 5 : zero

GAME_FIELD = [
	[1, 1, 1],
	[1, 1, 1],
	[1, 1, 1]
]

EMPTY_RAW_STEP = 1
USER_RAW_STEP  = 2
SERVER_RAW_STEP= 5

EMPTY_RAW   = "*\t"
USER_STEP   = "X\t"
SERVER_STEP = "O\t"

# --------------------------------------------------------------------------- #

def print_game_field (gf):
	for line in gf:
		for cel in line:
			if cel == SERVER_RAW_STEP: print(SERVER_STEP, end='')
			if cel == USER_RAW_STEP  : print(USER_STEP,   end='')
			if cel == EMPTY_RAW_STEP : print(EMPTY_RAW,   end='')
		print('')


# --------------------------------------------------------------------------- #

def get_msg_from_socket (socket, exception=True, ex=False):
	"""
	Get message from socket, if get not data,
	(mean connection was closed by peer)
	may Raise an Exception (if @exception = True)
	or exit (@ex == True)
	"""

	data = socket.recv(4096)

	if not data:
		socket.close()

		if (exception):
			raise Exception("Connection closed by peer.")
		else:
			print("Closed by peer.");

		if (ex):
			exit(1)

	return data

# --------------------------------------------------------------------------- #

def d (msg):
	print("D: {0}".format(msg))

# --------------------------------------------------------------------------- #

def is_step_correct (user_step, gf):
	"""
	Perform check, if @user_step is correct,
	according to current game (@gf)

	@param
		user_step : string in json format with user's turn

	@return
		True, if correct
		False, if not.
	"""

	d("step raw: {0}".format(user_step))


	try:
		# convert from json to dict
		step_dict = json.loads(user_step)

		# convert to int
		step_row = abs(int(step_dict["step"][0]))
		step_col = abs(int(step_dict["step"][1]))

		# check "step" for correctness (in the edges)
		length = len(gf)
		if step_row >= length or step_col >= length:
			raise Exception("Turn is out of game field.")

		# not the double-step
		if gf[step_row][step_col] != EMPTY_RAW_STEP:
			raise Exception("In the cell ({0}, {1}) already putted {2}!".format(step_row, step_col, gf[step_row][step_col]))

	except Exception as exp:
		print("smth realy shitful: {0}".format(exp))
		return False

	# return True if it is Ok
	return True

# --------------------------------------------------------------------------- #

def apply_turn (turn, board, data):
	"""
	Apply @turn into @board

	@param
		@turn : json-string. Should have 'step' field with *correct* data.
		@board : game field, where turns is saved
		@data : what to put into cell (should be smth like ttc.SERVER_RAW_STEP, ...)
	"""

	try:
		tmp = json.loads(turn)
		i = tmp["step"][0] # row
		j = tmp["step"][1] # col
		board[i][j] = data

	except Exception as exp:
		# it should never happend
		print(exp)
		print("Fix it! die.")
		sys.exit(1)


# --------------------------------------------------------------------------- #
