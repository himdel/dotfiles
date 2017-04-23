// ==UserScript==
// @name           Per reddit stylesheet removal
// @include        http://www.reddit.com/r/*
// @include        https://www.reddit.com/r/*
// ==/UserScript==

var noCSSsubreddits = {
  'reddithax' : 1,
  'redstone' : 1,
  'skiing' : 1,
  'chrome' : 1,
  'bsg' : 1,
};
var match = /www\.reddit\.com\/r\/(\w+)/i.exec( document.location.href );

if (match && match[1] && (match[1] in noCSSsubreddits))
  document.styleSheets[1].disabled = true;
