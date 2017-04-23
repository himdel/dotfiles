// ==UserScript==
// @name           Youtube HTML5 autopause
// @description    autopause for yt html5
// @author         Martin Hradil <himdel@seznam.cz>
// @namespace      http://himdel.mine.nu/
// @include        http://youtube.com/watch?*
// @include        http://*.youtube.com/watch?*
// @include        http://youtube.com/watch#*
// @include        http://*.youtube.com/watch#*
// @include        http://*.youtube.com/embed/*
// @include        http://youtube.com/embed/*
// @include        https://youtube.com/watch?*
// @include        https://*.youtube.com/watch?*
// @include        https://youtube.com/watch#*
// @include        https://*.youtube.com/watch#*
// @include        https://*.youtube.com/embed/*
// @include        https://youtube.com/embed/*
// @version        2011-08-01
// ==/UserScript==

window.addEventListener('load', function() {
  var video = document.getElementsByTagName('video')[0];
  video.pause();
  video.currentTime = 0;
}, false);
