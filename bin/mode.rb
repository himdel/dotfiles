#!/usr/bin/ruby

def showhelp
	$stderr << "#$0 [detect | <mode> | ls]\n"
	$stderr << "autodetect mode or set it manually or list modes\n"
end


if ARGV.empty?
	showhelp
	exit
end

if ARGV[0] == "detect"
	#
elsif ARGV[0] == "ls"
	#
else
	mode = ARGV[0]
end

`purple-remote 'setstatus?status=offline'` if mode == "offline"
