# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`$(document).ready(function(){
  $(".answer_post").on('touchstart click', function(){
    console.log("Rákattintták, he!");    
    $("> .post_chain", this).toggle();  
  });        
});`
