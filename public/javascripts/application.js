// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  if ($('#map').size()>0) {
    var paper = Raphael(document.getElementById('map'), cities.width+100, cities.height+100);

    $.each(cities.cities, function(i, city) {
      if (city.size==0) {
        $(paper.circle(50+city.x, 50+city.y, 1).attr({fill: '#777', stroke: '#777'}).node).attr('title', city.title);
      } else {
        $(paper.circle(50+city.x, 50+city.y, city.size).attr({fill: '#7d0000', stroke: '#7d0000'}).node).attr('title', city.title);
      }
    });
  }

  $('li.radio_enum input[value=other]').each(function(i,obj) {
    var $label = $(obj).closest('label');
    var $other = $('<input type="text" name="" placeholder="Свой вариант">').attr('value', $label.find('span').text());
    var name = $(obj).attr('name')
    $other.click(function(e) {
      obj.click();
      e.preventDefault();
      e.stopPropagation();
    });
    $other.change(function() {
      $(obj).attr('value', $other.attr('value'));
    });
    $label.find('span').replaceWith($other);
    if ($other.attr('value')!='') {
      $(obj).click() 
    }
  });
});
