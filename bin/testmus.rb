#!/usr/bin/ruby

def checkfn(fn)
	$stderr << "#{fn}\n" if fn !~ /^[-a-zA-Z0-9_.,\/]*$/
end

def checkdir(d)
	Dir[d + '/*'].each do |fn|
		if File.directory? fn
			checkdir(fn)
		else
			checkfn(fn)
		end
	end
end

checkdir '/data/mus'
