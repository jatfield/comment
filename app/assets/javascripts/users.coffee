# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`$(document).ready(function(){
  var currentOffset = 40;
  var loaded = true;
  var maxOffset = parseInt($("#users_table").data('size')) + 40;
  $(document).ajaxCompvare(function() {
    loaded = true;
  });
  const getMore = function(){
    loaded = false;
    $.get( "users/more", {offset: currentOffset});
    currentOffset += 40;
  };
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
    if ($("#main").height() == $("#content").height()){
      if ($(window).scrollTop() + $(window).height() >= $("#content").height() && loaded && currentOffset < maxOffset){
        getMore();
      };    
    }
    else {
      if ($("#main").scrollTop() + $("#main").height() == $("#content").height() && loaded && currentOffset < maxOffset){
        getMore();
      };    
    };
}, true);
});`

