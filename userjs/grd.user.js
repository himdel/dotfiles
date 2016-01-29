// ==UserScript==
// @name           Gray subscribe button for Google Reader
// @description    Changes the red button to grey
// @author         Martin Hradil <himdel@seznam.cz>
// @namespace      http://himdel.mine.nu/
// @include        http://www.google.com/reader/view/*
// @include        https://www.google.com/reader/view/*
// @version        2012-03-20
// ==/UserScript==

window.addEventListener('load', function() {
	var btn = document.getElementById('lhn-add-subscription')
	btn.classList.remove('jfk-button-primary')
	btn.classList.add('jfk-button-standard')
}, false)
