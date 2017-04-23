// ==UserScript==
// @name         flickr - redirect from evil to nice
// @namespace    http://your.homepage/
// @version      0.1
// @description  enter something useful
// @author       You
// @match        https://www.flickr.com/photos/*/*/
// @match        https://www.flickr.com/photos/*/*/in/**
// @grant        none
// ==/UserScript==

(function() {
  "use strict";

  var url = document.location.pathname.split('/');
  if (url.length == 4 && url[3])
    url[4] = "";
  if (url.length > 5 && url[4] == 'in') {
    url.length = 5;
    url[4] = "";
  }
  if (url.length != 5 || url[0] != "" || url[1] != 'photos' || !url[2] || !url[3] || url[4] != "") {
    console.error('wtf?', url);
    return;
  }

  url[4] = 'sizes/o';
  document.location.href = url.join('/');
})();
