class UsersController < Devise::RegistrationsController

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
		render :edit
	end

	def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  def after_update_path_for(user)
  	edit_musician_path(user)
  end

	## redirect the current user to musicians#show
	# to display current user as a musician
	def profile

	end
end
