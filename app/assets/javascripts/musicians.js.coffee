# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

## this function will query the messages_controller for the id of the last created reply
last_reply = ->
	# get the ids of the message, the current musician and the id of the message sender
	message_id = $('#message-id').text()
	musician_id = $('#musician_id').data("id")
	sender_id = $('#replies').data("sender")
	count = $('#replies').data("replies")

	# if all of these things are not empty, we are on the messages window with a message loaded
	# we can begin to check if there is a new response
	if message_id != "" && musician_id != "" && sender_id != ""
		$.ajax({
			type: "GET"
			url: "/musicians/" + musician_id + "/messages/" + message_id + "/last_created_reply"
			data:
				m_id: message_id
				reply_count: count
			dataType: "json"
		}).done( (response) ->
			if $.isNumeric(response.new_count)
				$('#replies').data("replies", response.new_count)
			$.each(response.replies, (i, item) ->
					id = response.replies[i].id
					sent_by = response.replies[i].sent_by

					# if the response is a number (meaning there is a reply for the message) and the
					# response was sent by someone other than the current user, load the reply
					console.log(musician_id + "    " + sent_by)
					if $.isNumeric(id) && musician_id != sent_by
						if $('.reply').last().data("reply-id") != id
							get_url = "/musicians/" + musician_id + "/messages/" + message_id + "/get_reply?m_id=" + message_id + "&r_id=" + id
							$.get(get_url, (data) ->
									$('.replies').append(data)
									$('.replies').scrollTop($('.replies')[0].scrollHeight))
			)
		)

## this function will use the data attribute on a message link to get the correct page content.
# effectively, we make a get request to the messages controller in order to return the partial
# corresponding to the desired message. we then append this in the right column of the messages page.
get_message = ->
	$('#message-pane').css('display', 'block')
	# $('#message-pane').html('')
	$('.not-selected').css('display', 'none')
	$('.hidden-loader').css('display', 'initial')

	message_id = $(this).data("id")
	musician_id = $('#musician_id').data("id")
	url = "/musicians/" + musician_id + "/messages/" + message_id + "/get_message?m_id=" + message_id
	$.get(url, (data) ->
		$('#message-pane').html(data)
	).done ->
		$('.replies').scrollTop($('.replies')[0].scrollHeight)
		
		# $('#reply-send-form').bind('keypress', (e) ->
		# 	code = e.keyCode || e.which
		# 	if code == 13
		# 		$(this).submit())
		
		$('#reply-send-form').submit ->
			message_id = $('#message-id').text()
			musician_id = $('#musician_id').data("id")

			post_url = "/musicians/" + musician_id + "/messages/" + message_id + "/create_reply"
			message_body = $('#reply-body').val()

			get_url = "/musicians/" + musician_id + "/messages/" + message_id + "/get_reply?m_id=" + message_id
			$.ajax({
				type: "POST"
				url: post_url
				data: 
					reply: 
						reply_body: message_body
						sent_by: musician_id
						message_id: message_id
				dataType: "json"
			}).done( ->
				$.get(get_url, (data) ->
					$('.replies').append(data))
			).fail( ->
				$.get(get_url, (data) ->
					$('.replies').append(data)
				).done( ->
					$('.replies').scrollTop($('.replies')[0].scrollHeight)
					$('#reply-body').val('')
				)
			)
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

## this will display the loading gif when uploading a song
display_loader = ->
	$('#song_upload').on 'click', ->
		$('.loader').css('display', 'block')

$ ->
	# redo the file select buttons to be more inline with the theme of the site
	$('input[type=file]').bootstrapFileInput();
	do display_loader									# display the loading gif when uploading a song
	do thumbnail											# manage thumbnail form display
	do buttons												# if the user clicks on the #add element, it will add a new genres element to the page
	do fill_in_field									# when the user clicks to upload a thumbnail, handle the event
	setInterval(last_reply, 5000)			# check for a new reply in the messages window every 5 seconds
	setInterval(password_check, 100)	# check if the user entered anything in the password field every 100 ms
	$('.msg-link').on 'click', get_message





