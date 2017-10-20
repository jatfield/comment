# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`$(document).ready(function(){
  let currentOffset = 40;
//windows.addeventlistener instead of jq .scroll() to make it bubble
  window.addEventListener('scroll', function(){
    if ($("#main").scrollTop() + $("#main").height()- 50 > $(window).height()){
      $.get( "users/more", {offset: currentOffset});
      currentOffset += 40;
    };    
}, true);
});`

