# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

  $(document).ready(function(){
    if ($("#error_explanation").length) { 
      $(".hidden_option").show();
    }
    $("#appearer_selector").change(function(){
      $("#ride_request_dcity").val('');   
      $("#ride_request_ddistrict").val('');   
      $("#ride_request_daddress").val('');   
      if ($("#appearer_selector").val() == "unhide"){
        $(".hidden_option").fadeIn('fast');  
      } 
      else { 
        $(".hidden_option").fadeOut('fast');
      }           
    });        
  });
