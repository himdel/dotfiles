// ==UserScript==
// @name         tumblr - hide related
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  hides related posts
// @author       himdel
// @match        https://*.tumblr.com/post/**
// @grant        none
// ==/UserScript==

(function() {
  'use strict';

  Array.from(document.querySelectorAll('.related-posts, .related-posts-wrapper')).forEach(function(el) {
    el.remove();
  });
})();
