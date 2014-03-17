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

SERVER_IP   = 'localhost'
SERVER_PORT = 64125

def say_hello (who_am_i):
	print("Hello, it's a {0}".format(who_am_i))

