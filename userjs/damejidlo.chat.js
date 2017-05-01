// ==UserScript==
// @name         damejidlo - remove chat
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.damejidlo.cz
// @grant        none
// ==/UserScript==

$(function() {
  const selector = '#livechat-compact-container, #livechat-full, #livechat-ping, #lc_invite_layer, #lc_overlay_layer';

  let removeOrWait = () => {
    if ($(selector).length) {
      $(selector).remove();
      // console.log('remove');
    } else {
      setTimeout(removeOrWait, 200);
      // console.log('wait');
    }
  };

  removeOrWait();
});
