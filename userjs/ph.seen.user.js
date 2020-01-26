// ==UserScript==
// @name         Pornhub seen
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  mark pornhub downloaded videos as seen
// @author       Martin Hradil <himdel@seznam.cz>
// @match        https://www.pornhub.com/*
// @grant        GM_addStyle
// ==/UserScript==


(function() {
    "use strict";

    var keys = [
      // grep pornhub.com ~/P/links.ERR ~/P/links.DONE | cut -d= -f2 | sort -u | sed -e 's/^/"/' -e 's/$/",/' | tr '\n' ' ' | xsel
    ];

    var addStyle = function() {
        var selectors = keys.map(function(key) {
            return '.videoblock.videoBox[_vkey="' + key + '"]';
        });

        GM_addStyle(selectors.join(", ") + ' { filter: invert(1); }');
    };

    var selector = '.videoblock.videoBox[_vkey]';
    var changeNodes = function(nodes) {
        var count = 0;
        nodes.forEach(function(element) {
            var vkey = element.getAttribute('_vkey');
            if (keys.includes(vkey)) {
                element.style.opacity = '0.1';
                count += 1;
            }
        });
        console.log('changeNodes', nodes.length, count);
    };
    var queryAll = function() {
        changeNodes(document.querySelectorAll(selector));
    };

    // both addStyle and queryAll do the same thing, looks like query is faster

    console.time('queryAll');
    queryAll();
    console.timeEnd('queryAll');

    //console.time('addStyle');
    //addStyle();
    //console.timeEnd('addStyle');

    // playlist lazy-load
    var targetNode = document.querySelector("#videoPlaylist");
    var observerOptions = {
        childList: true,
    };

    var callback = function(mutationList, observer) {
        mutationList.forEach((mutation) => {
            changeNodes(Array.from(mutation.addedNodes || []).filter((e) => e.matches && e.matches(selector)));
        });
    };

    var observer = new MutationObserver(callback);
    observer.observe(targetNode, observerOptions);

    window.seen = { refresh: queryAll };
})();
