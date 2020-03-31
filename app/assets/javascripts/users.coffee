# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`$(document).ready(function(){
  var moreRows ;
  var currentOffset = 20;
  var loaded = true;
  var maxOffset = parseInt($("#users_table").data('size')) + 40;

  const getMore = function(){
    loaded = false;
    $.get( "users/more", {offset: currentOffset});
    currentOffset += 20;
  };

  $(document).ajaxComplete(function() {
    loaded = true;
    needLink();
  });

  if ($("#content").height() < $(window).height()){
    $("#users_table").append('<tbody id = "more_rows"><tr><td colspan = 5><a href="#">SOROKAT! MÉG!</a></td></tr></tbody>');
  };

  $("#more_rows").click(function(){
    moreRows = $("#more_rows").detach();
    getMore();
  });

  const needLink = function(){
    if ($("#content").height() < $(window).height()){
      $("#users_table").append(moreRows);
      console.log("blah");
    };
  };

//windows.addeventlistener instead of jq .scroll() to make it bubble
  window.addEventListener('scroll', function(){
//      console.log("************");
//      console.log($("#main").scrollTop());
//      console.log($("#main").height());
//     console.log($("#content").scrollTop());
//      console.log($("#content").height());
//      console.log($(window).scrollTop());
//      console.log($(window).height());
//      console.log("************");
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

