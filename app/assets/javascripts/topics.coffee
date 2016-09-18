# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`$(document).ready(function(){
  $(".post_answer_link").click(function(){
    $("input[id='answer_to']").remove(); 
    console.log("Rákattintottál, he!");   
    $("#post_form_container > form").append('<input type="hidden" name="answer_to" id="answer_to" value='+$(this).attr("title")+'>');  
    tinyMCE.activeEditor.focus();
  });       
});`
