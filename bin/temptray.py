#!/usr/bin/env python
# coding=utf-8

import gtk, gobject, os
import egg.trayicon

class CPUTimer:
	def __init__(self, timeout):
		self.tray = egg.trayicon.TrayIcon("CPUTemp")
		self.label = gtk.Label('t00')
		self.tray.add(self.label)
		self.tray.show_all()

		self.color = gtk.gdk.Color('#ccc')
		self.color = self.tray.window.get_colormap().alloc_color( self.color, True, True )
		self.tray.window.set_background( self.color )

		# register a  timer
		gobject.timeout_add_seconds(timeout, self.timer_callback)

		self.tray.connect("destroy", lambda w: gtk.main_quit())
		self.tray.connect("delete_event", lambda w, e: gtk.main_quit())

		self.timer_callback()

	def timer_callback(self):
		cpu_temp = os.popen('sensors | grep "temp1:" | head -n1 | cut -d+ -f2 | cut -c1-2').read()
		self.label.set_text('t' + cpu_temp)

		# TODO still doesn't update
		self.color.red = 1280 * max(int(cpu_temp) - 50, 0)
		self.color = self.tray.window.get_colormap().alloc_color( self.color, True, True )
		self.tray.window.set_background( self.color )

		return True

if __name__ == '__main__':
	timer = CPUTimer(10) # sets update interval
	gtk.main()
