// ==UserScript==
// @name         facebook maybe
// @namespace    http://your.homepage/
// @version      0.1
// @description  enter something useful
// @author       You
// @match        https://www.facebook.com/events/*
// @grant        none
// ==/UserScript==

var join = document.querySelector('#event_button_bar').querySelector('[ajaxify*=join]');
if (join) {
    var maybe = document.createElement('a');
    maybe.setAttribute('href', '#');
    maybe.setAttribute('role', 'button');
    maybe.setAttribute('rel', 'async-post');
    maybe.setAttribute('class', join.getAttribute('class'));
    maybe.setAttribute('ajaxify', join.getAttribute('ajaxify').replace('/join', '/associate'));
    maybe.text = 'Maybe';

    join.parentElement.insertBefore(maybe, join);
}
