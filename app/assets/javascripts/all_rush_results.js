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
    }
});