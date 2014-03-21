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

#SERVER_IP   = 'bitthinker.com'
SERVER_IP   = 'localhost'
SERVER_PORT =  64500

# 1 : empty
# 2 : zero
# 5 : cross

GAME_FIELD = [
	[1, 1, 1],
	[1, 1, 1],
	[1, 1, 1]
]

def print_game_field (gf):
	for line in gf:
		print(line)



def get_msg_from_socket (socket, exception=True, ex=False):
	"""
	Get message from socket, if get not data, Raise an Exception
	(mean connection was closed by peer)
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

def d (msg):
	print("D: {0}".format(msg))
