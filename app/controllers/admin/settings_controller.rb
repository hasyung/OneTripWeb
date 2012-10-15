class Admin::SettingsController < Admin::ApplicationController

	load_and_authorize_resource
  helper_method :permission
	
  def index
     if request.post?
			if !params[:setting].blank?
				Setting.app_name = params[:setting][:app_name]
				Setting.app_keywords = params[:setting][:app_keywords]
				Setting.app_description = params[:setting][:app_description]
			end
			redirect_to :admin_root, :notice => t("helpers.messages.setting")
    end
		end
  
  private
	def self.permission
  	return Setting.name, "permission.controllers.admin.settings"
  end
end