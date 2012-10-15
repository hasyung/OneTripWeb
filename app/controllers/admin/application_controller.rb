class Admin::ApplicationController < ApplicationController
  
  before_filter :authenticate_user!

  # mobile-fu
  has_mobile_fu false

  #Cancan
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_exceptions_path, :alert => exception.message
  end

  def current_ability
	  @current_ability ||= AdminAbility.new(current_user)
	end

end
