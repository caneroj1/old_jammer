class UsersController < Devise::RegistrationsController
  # respond_to :html, :js

	## override the new/create methods for a registration controller in order
	# to pass new instance variables to the view
	def new
		@instrument_list = instrument_list
		@state_list = state_list
		super
	end

	def create
		@instrument_list = instrument_list
		@state_list = state_list
		super
	end

	def edit
    @musician = User.find_by_id(current_user)
		respond_to do |format|
      format.html { render :edit }
      format.js {}
    end
	end

	def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @musician = User.find(current_user.id)
    if @musician.update_attributes(account_update_params)
      set_flash_message :notice, :updated

      # Sign in the user bypassing validation in case their password changed
      sign_in @musician, :bypass => true
      redirect_to after_update_path_for(@musician)
    else
      render :edit
    end
  end

  def update_password
  	account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    
    @musician = User.find(current_user.id)
    if @musician.update(account_update_params)
    	set_flash_message :notice, :updated

      # Sign in the user by passing validation in case his password changed
      sign_in @musician, :bypass => true
      redirect_to edit_registration_path(@musician)
    else
      render :edit
    end
  end

  private

  def after_update_path_for(user)
  	edit_registration_path(user)
  end
end
