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
import json, re

#SERVER_IP   = 'bitthinker.com'
SERVER_IP   = 'localhost'
SERVER_PORT =  64501

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

DEBUG = 0

# --------------------------------------------------------------------------- #

def print_game_field (board):
	for line in board:
		for cel in line:
			if cel == SERVER_RAW_STEP: print(SERVER_STEP, end='')
			if cel == USER_RAW_STEP  : print(USER_STEP,   end='')
			if cel == EMPTY_RAW_STEP : print(EMPTY_RAW,   end='')
		print('')
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
	if DEBUG != 0:
		print("D: {0}".format(msg))

# --------------------------------------------------------------------------- #

def get_turn_from_user (board):
	"""
	Ask user about his turn.
	Validate it for correctnes (two integers, in the range of game board, not double step)

	@return
		json'ed user turn (string)
	"""

	tmp_json = False
	while True:

		tmp = raw_input(">: ")

		# convert to json, if it correct (int int)
		tmp_json = convert_step_to_json(tmp, board)
		d(tmp_json)
		if tmp_json is False:
			print("Bad turn. Please, try again!\n")
			continue;
		break;

	return tmp_json

# --------------------------------------------------------------------------- #

def convert_step_to_json (msg, board):
	"""
	Try to convert @msg into json and validate it for correctness.

	@param
		msg: string with user's input, like "int int"
		board: game board, where this step should be correct

	@return
		json-string,  if input correct
		False, if not correct
	"""

	d("input: %s" %msg)

	parts = re.split("\s*", msg)

	d("split into {0}".format(parts))

	try:
		row = int(float(parts[0]))
		col = int(float(parts[1]))

		answer = {}
		answer["step"] = [row, col]
		tmp_json = json.dumps(answer)

		if not is_step_correct(tmp_json, board):
			raise Exception("Incorrect coordinates, sorry.")

	except Exception as exp:
		d("Oops: {0}".format(exp))
		return False

	return tmp_json

# --------------------------------------------------------------------------- #

def is_step_correct (user_step, gf):
	"""
	Perform check, if @user_step is correct,
	according to current game (@gf)

	@param
		user_step : string in json format with user's turn (from (1,1))
		gf : game board, where this step should be correct.
			(from (0, 0))

	@return
		True, if correct
		False, if not.
	"""

	d("step raw: {0}".format(user_step))


	try:
		# convert from json to dict
		step_dict = json.loads(user_step)

		# convert to int
		i = int(step_dict["step"][0]) - 1
		j = int(step_dict["step"][1]) - 1

		# check "step" for correctness (in the edges)
		length = len(gf)
		if i >= length or i < 0 or j >= length or j < 0:
			raise Exception("Turn ({0},{1}) is out of game field.".format(i,j))

		# not the double-step
		if gf[i][j] != EMPTY_RAW_STEP:
			raise Exception("In the cell ({0}, {1}) has been put  {2}!".format(i, j, gf[i][j]))

	except Exception as exp:
		print("wow, {0}".format(exp))
		return False

	# return True if it is Ok
	return True

# --------------------------------------------------------------------------- #

def apply_turn (turn, board, data):
	"""
	Apply @turn into @board

	@param
		turn  : json-string. Should have 'step' field with *correct* data.
		board : game field, where turns is saved
		data  : what to put into cell (should be smth like SERVER_RAW_STEP, ...)
	"""

	#input should be humane-comfortable, so, pair like [1,2,3]x[1,2,3]
	#then, we decrease 1 and convert it into json
	# step is humanable. convert it. Fix func - is step correct

	try:
		tmp = json.loads(turn)
		i = tmp["step"][0] - 1  # row
		j = tmp["step"][1] - 1  # col
		board[i][j] = data

	except Exception as exp:
		# it should never happend
		print(exp)
		print("Fix it! die.")
		sys.exit(1)


# --------------------------------------------------------------------------- #
