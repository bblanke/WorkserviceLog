// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require_tree ../../../vendor/assets/javascripts/.

window.onload = function () {
	var archtype = Raphael("canvas", 300, 300);
archtype.customAttributes.arc = function (xloc, yloc, value, total, R) {
    var alpha = 360 / total * value,
        a = (90 - alpha) * Math.PI / 180,
        x = xloc + R * Math.cos(a),
        y = yloc - R * Math.sin(a),
        path;
    if (total == value) {
        path = [
            ["M", xloc, yloc - R],
            ["A", R, R, 0, 1, 1, xloc - 0.01, yloc - R]
        ];
    } else {
        path = [
            ["M", xloc, yloc - R],
            ["A", R, R, 0, +(alpha > 180), 1, x, y]
        ];
    }
    return {
        path: path
    };
};

var minutes = ($("#canvas").data("hours")) * 60;
console.log(minutes)

if (minutes > 180)
{
	minutes = 180;
}
else
{
	minutes = minutes;
}

//make an arc at 50,50 with a radius of 30 that grows from 0 to 40 of 100 with a bounce
var my_arc = archtype.path().attr({
    "stroke": "#4affe6",
    "stroke-width": 50,
    arc: [150, 150, 0, 180, 120]
});

animate(my_arc, minutes, ">")

};

function animate(my_arc, value, animate){
	
	my_arc.animate({
	    arc: [150, 150, value, 180, 120]
	}, 1500, animate);
};




