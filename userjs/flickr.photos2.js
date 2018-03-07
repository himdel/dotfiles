// ==UserScript==
// @name         flickr redirect
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.flickr.com/photos/*/*/
// @grant        none
// ==/UserScript==

let m = window.location.href.match(/\/photos\/([^\/]*)\/([^\/]*)\/?$/);
if (m) {
    let [, user, photo] = m;
    window.location.href = `https://www.flickr.com/photos/${user}/${photo}/sizes/o`;
}
