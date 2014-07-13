# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	# redo the file select buttons to be more inline with the theme of the site
	$('input[type=file]').bootstrapFileInput();
	do buttons
	setInterval(password_check, 100)

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
