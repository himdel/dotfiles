// ==UserScript==
// @name         damejidlo menu
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.damejidlo.cz/*
// @grant        none
// ==/UserScript==
/* jshint -W097 */
'use strict';

// Your code here...
$('#deliveryMenu .floating-category-list').each(function(_i, e) {
    function show() {
        $(e).addClass('visible').css({
            left: '245.5px',
            top: '24px',
            bottom: 'auto',
        });
    }
    
    $(window).on('scroll', show);
});
