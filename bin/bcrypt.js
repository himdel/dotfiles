#!/usr/bin/env node

var _ = require('lodash'),
	Q = require('q'),
	bcrypt = require('bcrypt-nodejs');

process.stdin.setEncoding('utf8');

process.stdin.on('readable', function(chunk) {
	var chunk = process.stdin.read();
	if (chunk === null)
		return;

	chunk = chunk.trim();
	chunk.split("\n").forEach(function(line) {
		line = line.trim();

		Q.nfcall(bcrypt.hash, line, null, null)
		.then(function(hash) {
			process.stdout.write(line + ":\t" + hash + "\n");
		});
	});
});
