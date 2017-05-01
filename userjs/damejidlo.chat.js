// ==UserScript==
// @name         damejidlo - remove chat
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.damejidlo.cz/
// @grant        none
// ==/UserScript==

$(function() {
  $('#livechat-compact-container, #livechat-full, #livechat-ping, #lc_invite_layer, #lc_overlay_layer').remove();
});
