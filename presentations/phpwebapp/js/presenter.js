var lastslide;
var oldurl;
var oldhash;
var currentslide = 0;

var toc = 0;

function showslide(id) {
	if (!id) return;
	var x = document.getElementById(id);
	var toc = document.getElementById("toc_" + id);

	if (!lastslide)
		lastslide = slides[0];

	window.location.hash = id;
	oldurl = location.href;

	if (id != lastslide) {
		document.getElementById(lastslide).style.display = "none";
		document.getElementById("toc_"+lastslide).style.backgroundColor = "";
	}

	x.style.display = "block";
	toc.style.backgroundColor = "#E8FFE8";
	
	lastslide = id;
	currentslide = (id.indexOf("_") == -1 ? "0" : id.substring(id.indexOf("_")+1,id.length));
	//$("#progress").css("width", ((currentslide / slides.length) * 100) + "%");
	if ($("#" + id).get(0).className == "slide") {
		$("#progress").html("Slide " + (parseInt(currentslide) + 1) + "/" + slides.length);
	} else {
		$("#progress").html("");
	}
	//alert(currentslide);
	//fix_buttons();
}

function watchurl() {
	if (oldurl != location.href) {
		//alert("URL CHANGED: \n" + location.href + "\n vs \n" + oldurl);
		oldurl = location.href;

		var i = oldurl.indexOf("#");
		if (i >= 0) {
			var id = oldurl.substring(i + 1, oldurl.length);
			currentslide = id.substring(id.indexOf("_")+1, id.length);
			currentslide = parseInt(currentslide);
			if (isNaN(currentslide)) {
				showslide(slides[0]);
				currentslide = 0;
			} else if (currentslide < 0 || currentslide >= slides.length) {
				showslide(slides[0]);
				currentslide = 0;
			} else {
				showslide(id);
			}
		} else {
			showslide(slides[0]);
			currentslide = 0;
		}
	}
	//setTimeout(watchurl, 100);
}

function loaded() {
	watchurl();
	if (!lastslide)
		lastslide = "slide_0";

	$("#slidelist-expander").mousedown(toggletoc);

	$(document).keypress(handlekey);
}

var tocwidth = "130px";
function toggletoc() { 
	toc ^= 1; 
	if (toc == 1) {
		$("#slidelist-expander").css("left",tocwidth);
		$("#slide-container").css("margin-left", tocwidth)
		$("#slidelist-panel").show();
	} else {
		$("#slidelist-expander").css("left","0");
		$("#slide-container").css("margin-left", "0");
		$("#slidelist-panel").hide()
	}
}

function setsidelistwidth(x) {
	var x = parseInt(x);
	document.getElementById("slidelist-expander").style.left = x + "px";
	document.getElementById("slidelist-panel").style.width = x + "px";
	document.getElementById("slide_" + currentslide).style.paddingLeft = x + 12 + "px";
}

function nextslide() {
	if (currentslide < slides.length - 1) {
		currentslide++;
		showslide(slides[currentslide]);
		//fix_buttons();
	}
}

function prevslide() {
	if (currentslide > 0) {
		currentslide--;
		showslide(slides[currentslide]);
		//fix_buttons();
	}
}

function handlekey(e) {
	var k = String.fromCharCode(e.which);

	// Opera sucks. doesn't show 'e.shiftKey' when shift. Uh.... Yeah.
	if (!e.keyCode && !e.which) return;

	// Ignore all alt+ctrl+shift uses:
	if (e.altKey || e.shiftKey || e.ctrlKey || e.metaKey) return;

	//alert(e.keyCode);

	var map = {
		't': toggletoc,
		'j': nextslide,
		'k': prevslide,
		' ': nextslide
	};

	map[e.DOM_VK_LEFT] = prevslide;
	map[e.DOM_VK_RIGHT] = nextslide;

	/* Opera, I hate you */
	map[37] = prevslide;
	map[39] = nextslide;


	// if k is null or undef
	if (k == "\0" || typeof k == "undefined") k = e.keyCode;

	//alert(e.keyCode + " / " + e.which + " / '" + k + "'"); 

	var f = map[k];

	if (f) {
		f();
		return false;
	}
}

$(document).ready(loaded);

/* Stuff I didn't write */
function setCookie(name, value, expires, path, domain, secure)
{
    document.cookie= name + "=" + escape(value) +
        ((expires) ? "; expires=" + expires.toGMTString() : "") +
        ((path) ? "; path=" + path : "") +
        ((domain) ? "; domain=" + domain : "") +
        ((secure) ? "; secure" : "");
}

function getCookie(name)
{
    var dc = document.cookie;
    var prefix = name + "=";
    var begin = dc.indexOf("; " + prefix);
    if (begin == -1)
    {
        begin = dc.indexOf(prefix);
        if (begin != 0) return null;
    }
    else
    {
        begin += 2;
    }
    var end = document.cookie.indexOf(";", begin);
    if (end == -1)
    {
        end = dc.length;
    }
    return unescape(dc.substring(begin + prefix.length, end));
}
