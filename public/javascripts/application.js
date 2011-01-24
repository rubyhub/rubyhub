// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  if ($('#map').size()>0) {
    var paper = Raphael(document.getElementById('map'), cities.width+100, cities.height+100);

    $.each(cities.cities, function(i, city) {
      if (city.size==0) {
        $(paper.circle(50+city.x, 50+city.y, 1).attr({fill: '#aaa', stroke: '#aaa'}).node).attr('title', city.title);
      } else {
        $(paper.circle(50+city.x, 50+city.y, city.size).attr({fill: '#7d0000', stroke: '#7d0000'}).node).attr('title', city.title);
      }
    });
  }
});
