// ==UserScript==
// @name           mbank
// @namespace      http://himdel.mine.nu/zlo
// @include        https://cz.mbank.eu/
// @include        https://online.mbank.cz/**ogin**
// ==/UserScript==

document.getElementById('customer').autocomplete = 'on';
document.getElementById('customer').value = '123';

document.getElementById('userID').autocomplete = 'on';
document.getElementById('userID').value = '123';
