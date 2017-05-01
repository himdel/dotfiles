// ==UserScript==
// @name         damejidlo - sort restaurants
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.damejidlo.cz/
// @grant        none
// ==/UserScript==

$(function() {
  var list = $('ul#restaurantListItems');

  list
  .children('li')
  .map(function(_idx, li) {
    // extract data
    var count = ~~ ($(li).find('.restaurant-rating').attr('title') || "").replace(/\D+/g, '');
    var percent = $(li).find('.restaurant-rating .restaurant-rating__text-top strong').text();

    // convert to numbers or both null
    percent = (count && percent) ? ( ~~ percent.replace(/\D+/g, '') ) : null;
    if (percent === null)
      count = null;

    return {
      element: li,
      rating: {
        count: count,
        percent: percent,
      },
    };
  })
  .map(function(_idx, o) {
    // extract ups and downs, if appliable
    if (! o.rating.count)
      return o;

    o.rating.ups = o.rating.count * (o.rating.percent / 100);
    o.rating.downs = o.rating.count * ((100 - o.rating.percent) / 100);

    var score = o.rating.ups - o.rating.downs;

    var order = Math.log10( Math.max(Math.abs( score ), 1) );
    var sign = (score > 0) ? 1 : ( (score < 0) ? -1 : 0 );

    o.rating.debug = { score: score, order: order, sign: sign };
    o.rating.reddit = sign * order;

    // console.log(o.rating);
    return o;
  })
  .sort(function(a, b) {
    // sort by rating, 100->0, then null

    if (! a.rating.count)
      return 1;
    if (! b.rating.count)
      return -1;

    // if (a.rating.percent < b.rating.percent)
    //   return 1;
    // if (a.rating.percent > b.rating.percent)
    //   return -1;

    if (a.rating.reddit < b.rating.reddit)
      return 1;
    if (a.rating.reddit > b.rating.reddit)
      return -1;

    return 0;
  })
  .map(function(_idx, item) {
    // pluck elements
    return item.element;
  })
  .detach()  // remove..
  .appendTo(list);  // ..and insert in new order
});
