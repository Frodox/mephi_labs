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
SERVER_PORT = 64124

GAME_FIELD = [
	[1, 1, 1],
	[1, 1, 1],
	[1, 1, 1]
]

def print_game_field (gf):
	for line in gf:
		print(line)


def say_hello (who_am_i):
	print("Hello, it's a {0}".format(who_am_i))


def get_msg_from_socket (socket):
	"""
	get message from socket, if get not data, Raise an Exception
	(mean connection was closed by peer)
	"""

	data = socket.recv(4096)
	if not data: 
		print("Closed by peer."); 
		socket.close()
		raise Exception("Connection closed by peer.")
	return data

