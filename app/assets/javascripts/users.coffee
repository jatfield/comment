# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`$(document).ready(function(){
  let currentOffset = 40;
  let loaded = true;
  let maxOffset = parseInt($("#users_table").data('size')) + 40;
  $(document).ajaxComplete(function() {
    loaded = true;
  });
//windows.addeventlistener instead of jq .scroll() to make it bubble
  window.addEventListener('scroll', function(){
      console.log("************");
      console.log($("#main").scrollTop());
      console.log($("#main").height());
      console.log($("#content").scrollTop());
      console.log($("#content").height());
      console.log(maxOffset);
      console.log($(window).scrollTop());
      console.log($(window).height());
      console.log("************");
//dont load until previous loaded, dont load if all loaded
//TODO: work for both screensizes
    if ($("#main").scrollTop() + $("#main").height() == $("#content").height() && loaded && currentOffset < maxOffset){
      loaded = false;
      $.get( "users/more", {offset: currentOffset});
      currentOffset += 40;
    };    
}, true);
});`

