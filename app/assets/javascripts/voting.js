$(document).ready(function()
{
	
	$(".show-hide").click(function()
       {
           if($(".detailed-results").hasClass("hidden"))
           {
               $(".detailed-results").removeClass("hidden");
           }
           else
           {
               $(".detailed-results").addClass("hidden");
           }   
       });
       
	$('form').submit(function(event)
	{
	    if($('form').hasClass('login'))
	    {
	        return;
	    }
	    
		var MAX_YES = 14;
		event.preventDefault();
		var t = $(this);
		if($(".Yes").size() >= MAX_YES && t.find("#vote_Yes:checked").size() == 1)
		{
			alert("You have already exceeded your Yes votes for this Round. Please vote No Or Abstain");
			return false;
		}
		else
		{
		$.ajax({
			url: t.attr("action"),
			type: t.attr("method"),
			dataType: "html",
			data : t.serialize(),
			success : function(data, textStatus, xhr)	
			{
					t.closest('td').html(data).addClass(data);
					t.parent().parent().find('.notes').html("Success.").removeClass("red");
					return false;
			},
			
			error : function(data, textStatus, xhr)
			{
				//alert("Your vote could not be registered.  Either you have already voted this round, or an unknown error occurred." + textStatus);
				t.parent().parent().find('.notes').html("Error.");
				return false;
			}	
		});
	}
	return false;	
	});	
});