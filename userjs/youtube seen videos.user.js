// ==UserScript==
// @name         youtube seen videos
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.youtube.com/watch
// @grant        none
// ==/UserScript==

var style = document.createElement('style');
style.innerHTML = `
  ytd-thumbnail-overlay-resume-playback-renderer {
    top: 0 !important;
    height: auto !important;
    background-color: rgba(128, 128, 128, 0.5) !important;
  }

  #progress.ytd-thumbnail-overlay-resume-playback-renderer {
    background-color: rgba(255, 0, 0, 0.4) !important;
  }
`;

// Get the first script tag
var ref = document.querySelector('script');

// Insert our new styles before the first script tag
ref.parentNode.insertBefore(style, ref);
