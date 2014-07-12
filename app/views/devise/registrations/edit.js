<% if @musician.lessons?[2] %>
	$("#lesson").after("<p class='form-control-static text-success yes'>Your profile now reflects your interest in giving lessons.</p>")
	$(".yes").fadeOut(6000)
<% else %>
	$("#lesson").after("<p class='form-control-static text-danger no'>Your profile no longer displays your interest in giving lessons.</p>")
	$(".no").fadeOut(6000)
<% end %>