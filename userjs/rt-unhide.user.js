// ==UserScript==
// @name           rt show quoted message parts
// @namespace      http://himdel.mine.nu/zlo
// @include        http://rt.matesova.cz/*
// @require        http://code.jquery.com/jquery-1.7.2.min.js
// ==/UserScript==

$(function() {
	$('.message-stanza-folder').hide();
	$('.message-stanza').removeClass('closed').addClass('open');
});
