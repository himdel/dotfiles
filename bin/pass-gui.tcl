#!/usr/bin/env wish

proc ok {pass} {
	puts $pass
	exit 0
}

label .l -text "Password: "
entry .e -width 40 -relief flat -bd 2 -textvariable password
focus .e
button .b -text OK -command { ok $password }
bind .e <Return> { ok $password }

grid .l -row 0 -column 0 -sticky e
grid .e -row 0 -column 1
grid .b -row 0 -column 2 -sticky e

raise .
