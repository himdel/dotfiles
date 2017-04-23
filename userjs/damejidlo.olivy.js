// ==UserScript==
// @name         damejidlo olivy
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.damejidlo.cz/*
// @grant        none
// ==/UserScript==
/* jshint -W097 */
'use strict';

$('ul.offer>li:has(:contains("olivy"))').each(function(_i, e) {
  $(e).css('background-color', 'olive');
});
