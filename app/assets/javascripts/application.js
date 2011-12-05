// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(document).ready(function(){
   $('form').submit(function(event)
   {
       var t = $(this);
       event.preventDefault(); 
        $.ajax({
           url: t.attr("action"),
           type: t.attr("method"),
           dataType: "html",
           data : t.serialize();
        success : function(data, textStatus, xhr)
        {
            t.closest("td").html(data);
            return false;
        },
        error : function(data, textStatus, xhr)
        {alert("Shit nuggets. Error. Try again.");
        return false;
            
            
        }
        
        });
   
   return false;
   });
   });