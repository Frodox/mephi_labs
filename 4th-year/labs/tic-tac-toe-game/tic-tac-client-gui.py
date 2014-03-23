#!/usr/bin/env python
# coding: utf-8

import gtk
import sys
import os
import subprocess
import re



class TicTacToeGame(gtk.Builder):

	def __init__ (self):
		"""
		Init GUI
		Try to Connect to the server
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

#-----------------------------------------------------------------------------#

	def __getattr__(self, attr):
		# reference to widgets from @glade by their id
		obj = self.get_object(attr)
		if not obj:
			raise AttributeError('object %r has no attribute %r' % (self, attr))
		setattr(self, attr, obj)
		return obj

# --------------------------------------------------------------------------- #


# --------------------------------------------------------------------------- #
# --------------------------- events handelers ------------------------------
# --------------------------------------------------------------------------- #

	def on_TicTacToeWindow_delete_event(self, window, event):
		"""
		Close button press handler
		"""

		print("Close button pressed")
		# do dome staff
		gtk.main_quit()

# --------------------------------------------------------------------------- #

	def on_cell_toggled (self, button, user_data=None):
		"""
		Toogle button
		Lock it, to prevent unpress,
		"""

		print("Toogled: ", button, user_data)
		button.set_sensitive(False)
		button.set_label("X")


# --------------------------------------------------------------------------- #
# --------------------------------------------------------------------------- #
# --------------------------------------------------------------------------- #


if __name__ == '__main__':
	ticTacToeGame = TicTacToeGame()
	gtk.main()
