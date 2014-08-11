# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

## this function will use the data attribute on a message link to get the correct page content.
# effectively, we make a get request to the messages controller in order to return the partial
# corresponding to the desired message. we then append this in the right column of the messages page.
subscriptions = []
get_message = ->
	$('#message-pane').css('display', 'block')
	$('.not-selected').css('display', 'none')
	$('.hidden-loader').css('display', 'initial')

	message_id = $(this).data("id")
	musician_id = $('#musician_id').data("id")
	url = "/musicians/" + musician_id + "/messages/" + message_id + "/get_message?m_id=" + message_id
	$.get(url, (data) ->
		$('#message-pane').html(data)
	).done ->
		$('.replies').scrollTop($('.replies')[0].scrollHeight)

		client = new Faye.Client('http://localhost:9292/faye')
		
		musician_id = $('#musician_id').data("id")
		message_id = $('#message-id').text()
		post_url = "/musicians/" + musician_id + "/messages/" + message_id + "/create_reply"

		if subscriptions.indexOf(message_id) == -1
			subscriptions.push(message_id)
			public_subscription = client.subscribe('/messages/' + message_id, (data) ->
				reply_string = ''
				if data["sender"] == musician_id
					reply_string += "<div class='col-xs-offset-2 col-xs-9 reply-r reply data-reply-id' " + data["sender"]+ ">"
				else
					reply_string += "<div class='col-xs-offset-2 col-xs-9 reply-l reply data-reply-id' " + data["sender"]+ ">"
				reply_string += "<table><tr><td class='body'>" + data["body"] + "</td><td class='img'><div class='pic'><img class='img-circle reply-pic' src='" + data["avatar"] + "'></div>"
				reply_string += "<div class='name-or-date'>" + data["name"] + "</div><div class='name-or-date'></div></td></tr></table></div>"
				$('#replies').append(reply_string)
				$('#replies').scrollTop($('.replies')[0].scrollHeight))

		$('#reply-send-form').submit ->
			body = $('#reply-body').val()
			$('#reply-body').val('')
			$.ajax({
				type: "POST"
				url: post_url
				data: 
					reply: 
						reply_body: body
						sent_by: musician_id
						message_id: message_id
				dataType: "json"
			}).done (data) ->
				client.publish('/messages/' + message_id, {
					body: data["body"],
					sender: data["sender"],
					time: data["time"],
					id: data["reply_id"],
					name: data["name"],
					avatar: data["avatar"]
				})
			false

## do not allow the user to submit a blank password form
password_check = ->
	if $('#new').val() == '' || $('#confirm').val() == ''
		$('#sub_pass').attr('disabled', true)
	else
		$('#sub_pass').attr('disabled', false)

## keeps track of the number of genre form inputs
# adds a new genre input field when 'Add More Genres' is clicked
# the user can only add up to 5 at a time
# after that, it displays a message saying they cannot add more.
buttons = ->
	forms = 1
	$('#add').on 'click', () ->
		forms += 1
		if forms <= 5
			$('#styles').before(
				'<div class="form-group">
					<label>Genre ' + forms + '</label>
					<input id="user_g' + forms + '" name="user[g' + forms + ']" type="text" class="form-control gen">
				</div>')
		if forms == 6
			$('#add').after('<p class="text-danger" id="genre-fill">You can only add 5 genres at a time.</p>')

## this function will keep track of whether the user is inside of the thumbnail
# for a song. if they are, it will display the inside of the picture with a link to upload
# a new thumbnail
thumbnail = ->
	$(".picture-box").bind "mouseenter mouseleave", ->
	  $(this).children().slideToggle(250)

## fill in the hidden field for the thumbnail upload form that specifies which song
# the thumbnail is being uploaded for
fill_in_field = ->
	$('.pic_link').bind 'click', ->
		$('#song_number').val($(this).data("number"))

# when the upload a song form is submitted, intercept the action, display the loader, and then
# submit the form
display_loader = ->
	$('.upload-song').submit ->
		$('.loader').css('display', 'block')
		$(this)[0].submit

$ ->
	# redo the file select buttons to be more inline with the theme of the site
	$('input[type=file]').bootstrapFileInput();
	do display_loader									# display the loading gif when uploading a song
	do thumbnail											# manage thumbnail form display
	do buttons												# if the user clicks on the #add element, it will add a new genres element to the page
	do fill_in_field									# when the user clicks to upload a thumbnail, handle the event
	# setInterval(last_reply, 5000)			# check for a new reply in the messages window every 5 seconds
	setInterval(password_check, 100)	# check if the user entered anything in the password field every 100 ms
	$('.msg-link').on 'click', get_message
	$('p.success, p.failure').fadeOut(6000)






