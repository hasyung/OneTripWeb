class Admin::HomeController < Admin::ApplicationController
	
	skip_authorization_check
  load_and_authorize_resource :province
  load_and_authorize_resource :place

	helper_method :permission

	def index
  @provinces = Province.created_desc
		@places = Place.created_desc
	end
	
end
