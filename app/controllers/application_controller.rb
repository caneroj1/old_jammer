class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # ensure that the user is logged in before they attempt to do anything
  # before_action :authenticate_user!

  ## these three methods are necessary to get devise forms on any page
	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def enable_devise
  	@resource_name = resource_name
  	resource
  	devise_mapping
  end
end
