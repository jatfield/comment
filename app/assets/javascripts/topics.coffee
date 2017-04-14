# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`$(document).ready(function(){
  $(".post_answer_link").click(function(){
    $("input[id='answer_to']").remove(); 
    $("#post_form_container > form").append('<input type="hidden" name="answer_to" id="answer_to" value='+$(this).attr("title")+'>');  
    tinyMCE.activeEditor.focus();
  });       
  $("#mobile_insert_link").click(function(){
    var link = prompt("Link?"); 
    var linkText = prompt("Szöveg?"); 
    if (linkText) {
      var linkWithText = '<a href = "' + link + '" target="_blank">' + linkText + '</a>'
      $("#full_text--mobile").val($('#full_text--mobile').val()+linkWithText); 
    };
    $("#full_text--mobile").focus();
  });       
  $("#mobile_insert_picture").click(function(){
    var pictureLink = prompt("Link?"); 
    var picture = '<img src ="' + pictureLink + '" >'
    if (pictureLink) {
      $("#full_text--mobile").val($('#full_text--mobile').val()+picture);
    }; 
    $("#full_text--mobile").focus();
  });
  $("#upload_images").click(function(){
    $("#upload_images_field").click();
  });
  $("#upload_images_field").change(function() {
    var numberOfFiles = document.getElementById("upload_images_field").files.length
    $("#upload_images").html("Képfeltöltés ("+numberOfFiles+")");
  });
});`
