// ==UserScript==
// @name         flickr - spaceball vs download
// @namespace    http://himdel.eu/
// @match        https://www.flickr.com/photos/*/*/sizes/*
// @grant        none
// ==/UserScript==

var img = document.querySelector('#allsizes-photo img');

var dl = document.createElement('a');
dl.setAttribute('href', img.src);
dl.appendChild( document.createTextNode("download") );

var par = img.parentElement;
par.appendChild(dl);

var spaceball = document.querySelector('.spaceball');
if (spaceball)
    spaceball.parentElement.removeChild(spaceball);
