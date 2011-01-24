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
    $other.click(function(e) {
      obj.click();
      e.preventDefault();
      e.stopPropagation();
    });
    $(obj).closest('li.radio_enum').find('input[type=radio]').click(function(e) {
      if (!$(obj).attr('checked')) {
        $other.attr('name', '');
      } else {
        $other.attr('name', $(obj).attr('name'));
      }
    });
    $label.find('span').replaceWith($other);
    if ($other.attr('value')!='') {
      $(obj).click() 
    }
  });
});
