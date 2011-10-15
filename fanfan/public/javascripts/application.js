// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function moveAnimate(element, newParent){
  var oldOffset = element.offset();
  element.appendTo(newParent);
  var newOffset = element.offset();

  var temp = element.clone().appendTo('body');
  temp    .css('position', 'absolute')
    .css('left', oldOffset.left)
    .css('top', oldOffset.top)
    .css('zIndex', 1000);
  element.hide();
  temp.animate( {'top': newOffset.top, 'left':newOffset.left}, 'slow', function(){
      element.show();
      temp.remove();
      });
}
