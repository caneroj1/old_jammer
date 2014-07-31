class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # ensure that the user is logged in before they attempt to do anything
  # before_action :authenticate_user!

  # whenever we are on a devise controller, change the permitted parameters
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!, except: [:index]

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

  # return a list of US states to be put into select dropdown forms easily
  def state_list
    ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
  end

  # return a list of instruments to be put into select dropdown forms easily
  def instrument_list
    ["Drums", "Electric Guitar", "Acoustic Guitar", "Bass", "Vocals", "Piano", "Alto Saxophone", "Tenor Saxophone", "Soprano Saxophone",
    "Baritone Saxophone", "Flute", "Violin", "Viola", "Cello"].sort_by { |u| u.downcase }
  end

  protected
  # specify what other parameters we want devise to accept when a user is signing up
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name << :last_name << :street << :city << :state << :instrument
  end
end
