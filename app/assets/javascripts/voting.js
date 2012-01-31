$(document).ready(function()
{
	
	
	$('form').submit(function(event)
	{
		var MAX_YES = 3;
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