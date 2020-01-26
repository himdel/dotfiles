// ==UserScript==
// @name         google lucky fix
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  fix chrome not redirecting automagically
// @author       himdel
// @match        https://www.google.com/url?q=*
// @grant        none
// ==/UserScript==

(function() {
    if (document.title !== "Redirect Notice")
        return;

    var m = document.documentURI.match(/^https:\/\/www.google.com\/url\?q=(.*)$/);
    if (! m)
        return;

    window.location.href = document.querySelector('a[href^=http]').href; // or m[1]
})();