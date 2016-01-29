window.addEventListener('load', function() {
	if (! _e("watch-player"))
		return;

	var imageURL = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAYAAAByUDbMAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9sGDRcwO74jARMAAAQESURBVDjLdZTbb1R1EMc/8ztn95ztbtstvVhZKhTSloIGgkAUIWgNJBolYtQnQxof5NE3E194xFuMD/4PliCiEBuRGK5qJEQhXATaclFaStvdstTd7e65/MaHFlIxfpNJZh7mm2/mOzPCArQ/M8zdX7ug6Xx6zdam53zPvLik3X3SccQvleOJkT9nf/Gc8OTFwd6LACa9HVs++rBfANzO80Q31wKwZMvIju6euoNbNvhO7/KEqiCCAKpxBIMnK3LhcmV4Yvjw+qkr780sFCMLi2Xbbh16dVt6R1dnAkkY1AERARFQBQVXVe8XY/nmSKl27dLwW8ULfYcf9Btv5RUAWjbdOPj85rodzW0uU4EwPmuZCg2FeEGEwmQVqRnhtZczyc6VXYfI7e97SFa72ovXe7Vvwzp/ZyZrmAyETD18sLOBx7Kz5K0yhSGvDnnrMBUL+VAYLyEvbE5pS+fafZJ6OgXgkDyVyCxf9Meq1Z5TNg4Vx7B6qbAq59GbS7MmZzh+s8ipSZfQJDAClQAqVUu5bKUx7ab/Gu8QWzxwzJjl7RuWPuEmC1WlEMB4YBgrW0IrBKqkPYfPX2njo62WUGc4MhoxXDLkQyFfBU2At2jd+0DKeB7PqqM6VVHGKzB0XyirAQOoAEI5gI1L6vnqzWa+2GYplItcycfkqzBdgUw26dK6t8c1jvTcK1vBV2IfJAM4Ajpn4kKEsdLX3ciJznq+/32aPQMV/FmHWBQnkV5sUDwFrM47IgbHAWPAyHzM5yKComR8Q2+rhbBEZEEBIfBd1XjMWleJVRzATyq+O7eAxvx7IwWYqYTsPXyRgTOC5+egEhBHYIPpGdeGtTNx4EnSKilXSScU3ygiIPNqZV7hZ4Nn+XG8jkBW0LoYKmM1wkg1nEVsYf8NNyhOnK01NpJpVU27KmnX4hmLkbnReQn4+uwQg7erVOq6aOmoo5SPME4NK0oYIEH+3G/o9VFjx7bfqd4rDEiE+MZSZyxRFBNFEdcnCuz+8iSn7SJaulfT2pQmbWLSJiZlFE+sBn+HNrjxzh4gcAA0jr6T9KZ323LJuvqsI/cUjg3d5qpN0r6ym4bGOlwsEil21hKVY6KZmOlRlYkLJwZtceBjIJ4jq56La5XOH0JZ1t/W4SeampPatLhZsm1pGhocUj6IVaKqJS7H1GZivTNk5ebPx3+qjby9CyjOnRNgsruw059MlkYL+4qVdS/59amWbLNLfdZopt5IIiFEVdXZopWJW5bLp+/H144Oflsd6e8H7v7nBRl/BbZ6Hdy2RKLpjdcbevo/zD21tPPxFR4JTyhOxoxeLunkpSNHK0O7PwU9DQT/+88egQPrO8hszGHwqU2WqR24DUw9SvIA/wCGi9iGTFTqXQAAAABJRU5ErkJggg==";
	var usercontent = [
		'<style>#e14332_skip-button{vertical-align:middle;cursor:pointer;background-image:url(\'',imageURL,'\');width:19px;height:19px;margin-left:5px;margin-right:5px;}</style>',
		'<div id="e14332_skip-button" class="inline-block" title="skip"></div>',
	].join("");

	var holder = null;
	if (_e("watch-headline-user-info"))
		holder = _e("watch-headline-user-info");
	else if (_e("masthead-nav"))
		holder = _e("masthead-nav");

	if (holder != null)
		holder.innerHTML += usercontent;
	else
		document.body.innerHTML = usercontent + document.body.innerHTML;

	setTimeout(function() {
		_e("e14332_skip-button").addEventListener("click", function() {
			skip_ad();
			_e("e14332_skip-button").style.display = "none";
		}, false);
	}, 500);

	ondemand_pageaction_show();
}, false);


function ondemand_pageaction_show() {
	chrome.extension.sendRequest({
		cmd : "showPageAction",
	});
}


function skip_ad() {
	if (_t("video").length > 0) {
		alert("New html5 template detected, skipping ads may be unstable!\n\nPlease send this url to support@drikcodes.com if it doesn't work properly.");
		var dv = _t("div");
		if (dv.length > 0) {
			x = dv[0];
			var i = 0;
			var x = dv[i];
			while ((x.className.indexOf("video-ads") < 0) && (i < dv.length)) {
				i++;
				x = dv[i];
			}
			if (x.className.indexOf("video-ads") > -1)
				x.style.display = "none";
		}
		return;
	}

	var s = _e("watch-player").getElementsByTagName("embed")[0].src;
	var v = location.href.split("v=")[1].split("&")[0];
	var w = location.href.split(":")[0] + "://www.youtube.com/v/" + v + "&version=3&autoplay=1&fs=1";
	var x = _e("watch-player").innerHTML;
	var p = x.indexOf(s);
	if (p > -1)
		x = x.substring(0,p) + w + x.substring(p + s.length);
	_e("watch-player").innerHTML = x;
}

function _e(id) {
	return document.getElementById(id);
}

function _t(name) {
	return document.getElementsByTagName(name);
}
