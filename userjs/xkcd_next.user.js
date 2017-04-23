// ==UserScript==
// @name       xkcd caption, next, keys
// @namespace  https://gist.github.com/zvodd/035e488f912aa18ba0c6
// @version    0.1
// @description  Show xkcd comic captions on the page. (Click the comic image to make it stay.)
// @match      http://xkcd.com/*
// @match      https://xkcd.com/*
// @match      http://www.xkcd.com/*
// @match      https://www.xkcd.com/*
// @copyright  2014+, zvodd & himdel
// ==/UserScript==

var comic = $("#comic > img"),
  caption = $("<p></p>").insertAfter(comic),
  next = $('.comicNav a[rel=next]'),
  prev = $('.comicNav a[rel=prev]'),
  rand = $('.comicNav a:not([rel])').filter(function(i,e) { return e.text == 'Random' });

caption.text( comic.attr("title") );
caption.css('margin', '0 30px 15px 30px');
caption.css('border', '1px solid gray');
caption.css('padding', '5px 8px');
caption.css('background-color', '#e8e8ff');
caption.css('font', 'initial');

if (next.attr('href').match(/.*#$/))
  next.css('background-color', '#000000');

function keys(o) {
  return window.onkeypress = function(e) {
    for (var k in o)
      if (e.keyCode == k.charCodeAt(0))
        o[k][0]['click']();
  };
}

keys({
  'r': rand,
  'n': next,
  'p': prev,

  'z': prev,
  'x': rand,
  'c': next,
});
