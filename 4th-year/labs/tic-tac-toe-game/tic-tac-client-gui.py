#!/usr/bin/env python
# coding: utf-8

import pygtk
pygtk.require('2.0')
import gtk
import sys
import os
import subprocess
import re

import tic_tac_common as ttc

class TicTacToeGame(gtk.Builder):

	def __init__ (self):
		"""
		Init GUI
		Connect to the server
		"""

		super(TicTacToeGame, self).__init__()

		self.add_from_file(os.path.join(os.path.dirname(__file__), "tic-tac-client-gui.glade"))
		self.connect_signals(self)

		# connect cell's event with signal handler and coordinates data
		self.cell1.connect("toggled", self.on_cell_toggled, "1 1")
		self.cell2.connect("toggled", self.on_cell_toggled, "1 2")
		self.cell3.connect("toggled", self.on_cell_toggled, "1 3")

		self.cell4.connect("toggled", self.on_cell_toggled, "2 1")
		self.cell5.connect("toggled", self.on_cell_toggled, "2 2")
		self.cell6.connect("toggled", self.on_cell_toggled, "2 3")

		self.cell7.connect("toggled", self.on_cell_toggled, "3 1")
		self.cell8.connect("toggled", self.on_cell_toggled, "3 2")
		self.cell9.connect("toggled", self.on_cell_toggled, "3 3")

		#self.TicTacToeWindow.connect("delete-event", self.on_window1_delete_event)
		self.TicTacToeWindow.show_all()



		ttc.DEBUG = 1

		self.s = self._get_client_socket()




#-----------------------------------------------------------------------------#

	def __getattr__(self, attr):
		"""
		reference to widgets from @glade-file by their id
		"""

		obj = self.get_object(attr)
		if not obj:
			raise AttributeError('object %r has no attribute %r' % (self, attr))
		setattr(self, attr, obj)
		return obj

# --------------------------------------------------------------------------- #


	def _get_client_socket (self):
		"""
		return client socket connected to the server. fail if error with msg
		"""

		self.statusbar.push(0, "Connecting to the server...")

		try:
			s = ttc.get_client_socket(exception=True)
			self.statusbar.push(0, "Connected")

		except Exception as exp:
			msg = gtk.MessageDialog(self.TicTacToeWindow
					, gtk.DIALOG_MODAL
					, gtk.MESSAGE_ERROR
					, gtk.BUTTONS_OK
					, str(exp)
					)
			msg.run()
			msg.destroy()
			ttc.d(exp)
			sys.exit(1)

		return s


# --------------------------------------------------------------------------- #
# --------------------------- events handelers ------------------------------
# --------------------------------------------------------------------------- #

	def on_TicTacToeWindow_delete_event(self, window, event):
		"""
		Close button press handler
		"""

		ttc.d("Close button pressed")
		self.s.close()

		gtk.main_quit()

# --------------------------------------------------------------------------- #

	def on_cell_toggled (self, button, user_data=None):
		"""
		Toogle button
		Lock it, to prevent unpress,
		"""

		# lock UI
		self.TicTacToeWindow.set_sensitive(False)
		self.statusbar.push(0, "Pressed btn with coords: {}".format(user_data))

		# lock cell
		button.set_sensitive(False)

		# apply user turn
		button.set_label(ttc.USER_STEP)

		# create correct json-turn

		# send turn to the server

		# get answer

		# check for errors and winners in the answer

		# if winner - show msg and exit after that

		# get server's turn

		# apply server turn

		# check for winners ot TIE

		# exit with msg if winner exist

		# unlock UI
		self.TicTacToeWindow.set_sensitive(True)

		# exit handler and wait for user turn
		return;


# --------------------------------------------------------------------------- #
# --------------------------------------------------------------------------- #
# --------------------------------------------------------------------------- #


if __name__ == '__main__':
	ticTacToeGame = TicTacToeGame()
	gtk.main()
