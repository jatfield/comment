# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`$(document).ready(function(){
  $(".answer_post").click(function(){
    console.log("Rákattintottál, he!");    
    $("> .post_chain", this).toggle();  
  });       
});`
