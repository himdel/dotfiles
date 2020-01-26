// ==UserScript==
// @name         damejidlo - sort restaurants
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.damejidlo.cz/
// @grant        none
// ==/UserScript==

setTimeout(function() {
    const list = document.querySelector('.Restaurant-list__content');
    const items = list.querySelectorAll('.Restaurant-box');

    const num = (elem) => {
        if (! elem) {
            return null;
        }

        let s = elem.innerText.trim();
        return ~~(s.replace(/\D+/g, ''));
    };

    Array.from(items)
    .map(function(box) {
        // extract data
        let count = num(box.querySelector('.RestaurantRating__rating-count'));
        let percent = num(box.querySelector('.RestaurantRating__info'));

        // both or nothing
        if (!count || !percent) {
            count = null;
            percent = null;
        }

        return {
            element: box,
            rating: {
                count,
                percent,
            },
        };
    })
    .map(function(o) {
        // extract ups and downs, if appliable
        if (! o.rating.count) {
            return o;
        }

        o.rating.ups = o.rating.count * (o.rating.percent / 100);
        o.rating.downs = o.rating.count * ((100 - o.rating.percent) / 100);

        var score = o.rating.ups - o.rating.downs;

        var order = Math.log10( Math.max(Math.abs( score ), 1) );
        var sign = (score > 0) ? 1 : ( (score < 0) ? -1 : 0 );

//		o.rating.debug = { score: score, order: order, sign: sign };
        o.rating.reddit = sign * order;

        return o;
    })
    .sort(function(a, b) {
        // sort by rating, 100->0, then null

        if (! a.rating.count) {
            return 1;
        }
        if (! b.rating.count) {
            return -1;
        }

        if (a.rating.reddit < b.rating.reddit) {
            return 1;
        }
        if (a.rating.reddit > b.rating.reddit) {
            return -1;
        }

        return 0;
    })
    .map(function(item) {
        // pluck elements
        return item.element;
    })
    .forEach((element) => {
        // remove and insert in new order
        list.removeChild(element);
        list.appendChild(element);
    });
}, 8000); // TODO mutationobserver to wait for load?
